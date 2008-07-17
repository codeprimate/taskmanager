class ProjectsController < ResourceController::Base
  before_filter :login_required

  private

  def object
    @object ||= self.current_user.projects.find(param)
  end

  def collection
    @collection ||= self.current_user.projects
  end
end
