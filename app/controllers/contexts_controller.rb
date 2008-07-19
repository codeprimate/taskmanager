class ContextsController < ResourceController::Base
  before_filter :login_required

  belongs_to :user

  layout 'main'

  create do
    build do
      @object = self.current_user.contexts.create(params[:context])
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
