class TasksController < ResourceController::Base
  before_filter :login_required

  layout 'main'

  belongs_to :project, :context

  create do
    build do
      @object = self.current_user.tasks.create(params[:task])
    end
  end

  def object
    @object ||= self.current_user.tasks.find_by_permalink(param)
  end

  def collection
    @collection ||= (parent_object || self.current_user).tasks
  end

end
