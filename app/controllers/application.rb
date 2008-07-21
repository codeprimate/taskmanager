# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  include ApplicationHelper

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '23fd83485424f98b2c3683501173ed8d'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  include AuthenticatedSystem

  # hacky hack! Overridden by resource_controller
  def parent_object
    nil
  end

  # Find tasks that are children of the parent_obj filtered by the current 
  # context as saved in the session or indicated by the resource path. Additionally
  # these tasks are filtered by completion time, only showing uncompleted tasks
  # or tasks that have been completed in the past day.
  # 
  # Optionally provide a second argument to indicate whether to return 
  # completed tasks. Default is false.
  def contextual_task_finder(parent_obj, show_completed=false)
    recently_active_tasks_cond_str = " AND (completed IS NULL OR completed >= ?)"
    recently_active_tasks_cond_args = [(Time.now - 1.day).to_s(:db)]
    if (current_project || current_context)
      conditions_arr = []
      conditions_args = []
      if current_context
        conditions_arr << "context_id = ?"
        conditions_args << current_context.id
      end
      if current_project
        conditions_arr << "project_id = ?"
        conditions_args << current_project.id
      end
      conditions_str = conditions_arr.join(' AND ')
      conditions_str += recently_active_tasks_cond_str
      conditions_args += recently_active_tasks_cond_args
      conditions = [conditions_str] + conditions_args
puts conditions.inspect
      if show_completed
        parent_obj.tasks
      else
        return parent_obj.tasks.find(:all, :conditions => conditions)
      end
    else
      if show_completed
        return parent_obj.tasks
      else
        conditions = [recently_active_tasks_cond_str] + recently_active_tasks_cond_args
        return parent_obj.tasks.find(:all, :conditions => conditions)
      end
      return task_base
    end
  end
  
  # Redirect to the active context or root path
  def redirect_to_current_context
    if current_project
      redirect_to project_path(current_project)
    elsif current_context
      redirect_to context_path(current_context)
    else
      redirect_to root_path
    end
  end
  
  # Set current_project or current_context session variables based on a task's
  # context or project
  def set_context_session
    if @object.project
      session[:current_project] = @object.project.id
    end
    if @object.context
      session[:current_context] = @object.context.id
    end
  end
  
end
