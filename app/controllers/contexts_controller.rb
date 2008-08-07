class ContextsController < ResourceController::Base
  before_filter :login_required

  belongs_to :user

  layout 'main'

  create.build { @object = self.current_user.contexts.create(params[:context]) }

  show.after do
    session[:current_context] = object.id
    @tasks = contextual_task_finder(object)
  end

  # Reset Context to ALL
  def reset
    session[:current_context] = nil
    redirect_to_current_context
  end
  
   destroy do 
    after {session[:current_context] = nil }
    wants.html {redirect_to_current_context }
  end
  
  private

  def object
    @object ||= self.current_user.contexts.find_by_permalink(param)
  end

  def collection
    @collection ||= self.current_user.contexts
  end

end
