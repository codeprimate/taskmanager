# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def current_context_from_session
    if session[:current_context]
      context = self.current_user.contexts.find(session[:current_context])
    else
      context = nil
    end
    return context
  end

  def current_project_from_session
    if session[:current_project]
      project = self.current_user.projects.find(session[:current_project])
    else
      project = nil
    end
    return project
  end

  def current_context
    if @object.is_a?(Context)
      @current_context ||= @object
    elsif @parent_object.is_a?(Context)
      @current_context ||= @parent_object
    else
      @current_context ||= (current_context_from_session || self.current_user.contexts.find_by_permalink(params[:context_id]))
    end
    #    @current_context ||= self.current_user.contexts.find_by_name("Inbox")
    return @current_context
  end

  def current_context_id
    return (@current_context_id ||= (current_context ? current_context.id : nil))
  end

  def current_project
    if @object.is_a?(Project)
      @current_project ||= @object
    elsif @parent_object.is_a?(Project)
      @current_project ||= @parent_object
    else
      @current_project ||= (current_project_from_session || self.current_user.projects.find_by_permalink(params[:project_id]))
    end
    return @current_project
  end

  def current_project_id
    return (@current_project_id ||= (current_project ? current_project.id : nil))
  end
  
  # Call this to prepare the named PeriodicalExecuter, and only from a regular view,
  #  not from AJAX
  def prepare_named_executer(js_prefix, object_id)
    js_var = "#{js_prefix}_#{object_id}"
    code = "
  <script type='text/javascript'>
      var #{js_var} = null;
      function stop_executer_#{js_var}(){
        #{js_var}.stop();
        return false;
      }
  </script>"
  end
  
  # Creates a PeriodicalExecutor bound to a variable so that it may be stopped
  #  prepare_named_executer() must be called in a regular view first with the same name
  # this is due to a javascript variable scope issue
  def named_periodical_executer(options, js_prefix, object_id)
    js_var = "#{js_prefix}_#{object_id}"
    frequency = options[:frequency] || 10 # every ten seconds by default
    code = "#{js_var} = new PeriodicalExecuter(function() {#{remote_function(options)}}, #{frequency});"
    javascript_tag(code)
  end

  # Stop the named PeriodicalExecuter
  def stop_named_periodical_executer(js_prefix, object_id)
    js_var = "#{js_prefix}_#{object_id}"
    code = "stop_executer_#{js_var}()"
    javascript_tag(code)
  end

end
