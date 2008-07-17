class TasksController < ResourceController::Base
  before_filter :login_required

  belongs_to [:project, :context]
end
