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
    object.completed = (object.completed.nil? ? Time.now : nil)
    object.save
    respond_to do |format|
      format.js { }
      format.xml { render :xml => object.to_xml }
    end
  end
  
  def increment_time
    object.time_spent ||= 0 
    object.time_spent += 1
    object.save!
    object.reload
    respond_to do |format|
      format.js {}
    end
  end
  
  def toggle_timer
    object
    @enable = params[:disable].nil?
    respond_to do |format|
      format.js { }
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
