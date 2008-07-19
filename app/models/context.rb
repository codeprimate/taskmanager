class Context < ActiveRecord::Base
  has_permalink :name

  has_many :tasks
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :user_id
  validates_uniqueness_of :name, :scope => :user_id

  attr_protected :user_id

  def to_param
    permalink
  end

  def self.find_by_param(*args)
    find_by_permalink(*args)
  end

end
