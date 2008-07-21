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
    build { @object = self.current_user.tasks.create(params[:task]) } 
    after { set_context_session }
    wants.html { redirect_to_current_context }
  end
 
  destroy.wants.html { redirect_to_current_context }
  update.wants.html { redirect_to_current_context }
  
  def completed
    @collection = contextual_task_finder((parent_object || self.current_user), true)
    render :layout => "tasks/index"
  end
  
  def toggle_complete
    @object = self.current_user.tasks.find(params[:id])
    if @object.completed.nil?
      @object.completed = Time.now
    else
      @object.completed = nil
    end
    @object.save
    respond_to do |format|
      format.js { }
      format.xml { render :xml => @object.to_xml }
    end
  end
  
  private
  
  def object
    @object ||= self.current_user.tasks.find_by_permalink(param)
  end

  def collection
    @collection ||= contextual_task_finder((parent_object || self.current_user),true)
  end
  



end
