class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :user
  validates_presence_of :name
  validates_presence_of :user_id

  def to_param
    id
  end

  def find_by_param(*args)
    find(*args)
  end

end
