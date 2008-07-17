class Task < ActiveRecord::Base
    belongs_to :project
    belongs_to :context
end
