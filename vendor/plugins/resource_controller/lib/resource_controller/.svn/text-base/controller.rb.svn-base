module ResourceController
  module Controller    
    NAME_ACCESSORS = [:model_name, :route_name, :object_name]  

    def self.included(subclass)
      subclass.class_eval do
        extend  ResourceController::Accessors
        extend  ResourceController::ClassMethods
        extend  ResourceController::Definer
        include ResourceController::Helpers
        include ResourceController::Handler

        # these need to behave a little bit differently than the normal class_reader_writers, since they don't pick out the first argument
        # if one exists, because we need to be able to distinguish between an array being passed, and a normal arg
        def self.belongs_to(*args)
          unless args.empty?
            write_inheritable_attribute(:belongs_to, args)
          end
          
          read_inheritable_attribute(:belongs_to)
        end
        
        def belongs_to
          self.class.belongs_to
        end
        
        class_reader_writer *NAME_ACCESSORS
        NAME_ACCESSORS.each { |accessor| send(accessor, controller_name.singularize.underscore) }

        # Iterate all routes defined in routes.rb to create accessors for them
        @actions = []
        ActionController::Routing::Routes.routes.select{|r| r.requirements[:controller] == controller_path}.each do |route|
          @actions << route.requirements[:action].to_sym
          define_route_action route
        end
        logger.warn "Warning: No routes defined for #{controller_name} controller" if @actions.empty?

        self.helper_method :object_url, :edit_object_url, :new_object_url, :collection_url, :object, :collection, 
                             :parent, :parent_type, :parent_object, :parent_model, :model_name, :model, :object_path, 
                             :edit_object_path, :new_object_path, :collection_path, :hash_for_collection_path, :hash_for_object_path, 
                                :hash_for_edit_object_path, :hash_for_new_object_path, :hash_for_collection_url, 
                                  :hash_for_object_url, :hash_for_edit_object_url, :hash_for_new_object_url, :parent?,
                                    :collection_url_options, :object_url_options, :new_object_url_options
      end
    end
  end
end
