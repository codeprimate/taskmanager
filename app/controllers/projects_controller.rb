class ProjectsController < ResourceController::Base
  before_filter :login_required

  layout 'main'

  create do
    build do
      @object = self.current_user.projects.create(params[:project])
    end
  end

  show do
    after do
      session[:current_project] = object.id
      @tasks = contextual_task_finder(object)
    end
  end

  def reset
    session[:current_project] = nil
    if current_context
      redirect_to context_path(current_context)
    else
      redirect_to root_path
    end
  end
  
  private

  def object
    @object ||= self.current_user.projects.find_by_permalink(param)
  end

  def collection
    @collection ||= self.current_user.projects
  end

end
