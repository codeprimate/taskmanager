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

  def parent_object
    nil
  end

  
  def contextual_task_finder(parent_obj)
    if (current_project || current_context)
      conditions_arr = []
      conditions_args = []
      if current_context
        conditions_arr << "context_id = #{current_context.id}"
        conditions_args << current_context.id
      end
      if current_project
        conditions_arr << "project_id = #{current_project.id}"
        conditions_args << current_project.id
      end
      conditions_str = conditions_arr.join(' AND ')
      conditions = [conditions_str] + conditions_args
      return parent_obj.tasks.find(:all, :conditions => conditions)
    else
      return parent_obj.tasks
    end
  end

end
