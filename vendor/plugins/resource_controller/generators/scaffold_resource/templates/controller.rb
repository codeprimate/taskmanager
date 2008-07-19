# see the resource_controller readme for more information
class <%= controller_class_name %>Controller < ResourceController::Base
    # # if this controller is nested set the parent reference here
    # # multiple items can be specified but only one will be referenced at a time
    # belongs_to :some_other_object, :yet_another_object
    # even for polymorphs
    # belongs_to :item, :polymorphic=>true
  
    # if this controller uses a model named differently from the controller set it here
    # model_name :<%= singular_name %>
    
    # if this controller views reference an object named differently from this controller set it here
    # object_name :<%= singular_name %>
    
    # if this controller usese routes named differently from this controller set it here
    # route_name :<%= singular_name %>

    # # to facilitate polymorphic views you can set this controllers views to another controller
    # def self.controller_path
    #   SomeOtherController.controller_path
    # end

    # # for each of the standard crud actions you can override default behaviors using a very simple DSL
    # # each action with the exception of :new is expressed in a very sensible fashion
    # new_action do
    #   # override how the object is built
    #   build {}
    #   # set a rescue
    #   rescues ActiveRecord::RecordNotFound
    #   # set a before filter
    #   before {}
    #   # redefine the action
    #   action {}
    #   # set after filter
    #   after {}
    #   # set the success flash message
    #   flash {}
    #   # set the failure flash message
    #   failure.flash {}
    #   # set success mime handlers
    #   wants {}
    #   # set the failure mime handlers
    #   failure.wants {}
    # end

  private 
  
    # # override this method to redefine how objects are found
    # def object
    #   @object ||= end_of_association_chain.find(param) unless param.nil?
    #   @object    
    # end
  
    # # override this method to redefine how object collections are found
    # def collection
    #   end_of_association_chain.find(:all)
    # end

    # # override this method to redefine how parent ojects are found
    # def parent_object
    #   parent? ? parent_model.find_by_param(parent_param) : nil
    # end
  
end
