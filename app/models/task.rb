# == Schema Information
# Schema version: 20080719175833
#
# Table name: tasks
#
#  id         :integer         not null, primary key
#  name       :string(255)     
#  project_id :integer         
#  context_id :integer         
#  user_id    :integer         
#  due        :datetime        
#  completed  :datetime        
#  note       :text            
#  time_spent :integer         
#  created_at :datetime        
#  updated_at :datetime        
#  permalink  :string(255)     
#

class Task < ActiveRecord::Base
  ACTIVE_COMPLETED_CUTOFF = 1  # active tasks may have been completed within this many hours ago
  
  belongs_to :project
  belongs_to :context
  belongs_to :user

  validates_presence_of :name, :user_id, :context_id
  validates_uniqueness_of :name, :scope => [:user_id, :project_id, :context_id]

  named_scope :active, lambda { 
      { :conditions => "tasks.completed >= '#{(Time.now - ACTIVE_COMPLETED_CUTOFF.hours).to_s(:db)}' OR tasks.completed IS NULL", 
        :order => "completed asc, created_at desc"}
    }
    
  named_scope :incomplete, :conditions => "completed IS NULL", :order => "completed asc, created_at desc"
  named_scope :complete, :conditions => "completed IS NOT NULL", :order => "completed asc, created_at desc"

  has_permalink :name

  def to_param
    permalink
  end

  def find_by_param(*args)
    find_by_permalink(*args)
  end
  
  def priority_string
    time_left = (due || Time.now) - Time.now
    if time_left < 0
      return "overdue"
    end
    if time_left < 1.day
      return "urgent"
    end
    if time_left > 1.day
      return "normal"
    end
  end
end
