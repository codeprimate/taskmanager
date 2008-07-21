class Project < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy, :order => "completed asc, created_at desc"
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
