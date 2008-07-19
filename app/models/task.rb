class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :context
  belongs_to :user

  validates_presence_of :name, :user_id, :context_id
  validates_uniqueness_of :name, :scope => [:user_id, :project_id, :context_id]

  has_permalink :name

  def to_param
    permalink
  end

#  def find_by_param(*args)
#    find(*args)
#  end
end
