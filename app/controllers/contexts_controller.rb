class ContextsController < ResourceController::Base
  before_filter :login_required

  belongs_to :user

  create do
    build do
      params[:context][:user] = self.current_user
      @object = Context.create(params[:context])
    end
  end


  private


  def object
    @object ||= self.current_user.contexts.find(param)
  end

  def collection
    @collection ||= self.current_user.contexts
  end

end
