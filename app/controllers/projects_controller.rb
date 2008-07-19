class ProjectsController < ResourceController::Base
  before_filter :login_required

  layout 'main'

  create do
    build do
      @object = self.current_user.projects.create(params[:project])
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
