class ContextsController < ResourceController::Base
  before_filter :login_required

  belongs_to :user

  layout 'main'

  create do
    build do
      @object = self.current_user.contexts.create(params[:context])
    end
  end

  show do
    after do
      session[:current_context] = object.id
      @tasks = contextual_task_finder(object)
    end
  end

  def reset
    session[:current_context] = nil
    if current_project
      redirect_to project_path(current_project)
    else
      redirect_to root_path
    end
  end
  
  private


  def object
    @object ||= self.current_user.contexts.find_by_permalink(param)
  end

  def collection
    @collection ||= self.current_user.contexts
  end

end
