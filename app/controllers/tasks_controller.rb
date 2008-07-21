class TasksController < ResourceController::Base
  before_filter :login_required

  layout 'main'

  belongs_to :project, :context

  new_action do
    build do
      @object = self.current_user.tasks.new(params[:task])
      @object.project_id ||= current_project_id
      @object.context_id ||= current_context_id
    end
  end
  
  create do
    build do
      @object = self.current_user.tasks.create(params[:task])
    end
    after do
      if @object.project
        session[:current_project] = @object.project.id
      end
      if @object.context
        session[:current_context] = @object.context.id
      end
    end
  end

  private
  
  def object
    @object ||= self.current_user.tasks.find_by_permalink(param)
  end

  def collection
#    @collection ||= (parent_object || self.current_user).tasks
    @collection ||= contextual_task_finder((parent_object || self.current_user))
  end
  


end
