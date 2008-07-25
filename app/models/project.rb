# == Schema Information
# Schema version: 20080719175833
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)     
#  note       :text            
#  user_id    :integer         
#  created_at :datetime        
#  updated_at :datetime        
#  permalink  :string(255)     
#

class Project < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :user_id

  validates_uniqueness_of :name, :scope => :user_id

  attr_protected :user_id

  has_permalink :name

  def to_param
    permalink
  end

  def self.find_by_param(*args)
    find_by_permalink(*args)
  end

end
