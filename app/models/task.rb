class Task < ActiveRecord::Base
    belongs_to :project
    belongs_to :context
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
