class MwdScaffoldGenerator < Rails::Generator::NamedBase
  attr_reader :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_singular_name,
                :controller_plural_name,
                :resource_edit_path,
                :default_file_extension,
                :generator_default_file_extension
  alias_method :controller_file_name, :controller_singular_name
  alias_method :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super
    
    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end

  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions(controller_class_path, "#{controller_class_name}Controller", "#{controller_class_name}Helper")
      m.class_collisions(class_path, "#{class_name}")

      # Controller, helper, views, and test directories.
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))

      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/helpers', class_path))
      m.directory(File.join('spec/models', class_path))
      m.directory File.join('spec/views', controller_class_path, controller_file_name)
      m.directory(File.join('spec/fixtures', class_path))
                      
      m.template('controller.rb', File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb"))
      m.template('helper.rb', File.join('app/helpers', controller_class_path, "#{controller_file_name}_helper.rb"))
      m.template('model.rb', File.join('app/models', class_path, "#{file_name}.rb"))
      scaffold_views.each do |action|
        m.template("view_#{action}.erb",File.join('app/views', controller_class_path, controller_file_name, "#{action}.html.erb"))
      end

      m.template('rspec/functional_spec.rb', File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb"))
      m.template('rspec/routing_spec.rb', File.join('spec/controllers', controller_class_path, "#{controller_file_name}_routing_spec.rb"))
      m.template('rspec/helper_spec.rb', File.join('spec/helpers', class_path, "#{controller_file_name}_helper_spec.rb"))
      m.template('rspec/unit_spec.rb', File.join('spec/models', class_path, "#{file_name}_spec.rb"))
      m.template('fixtures.yml', File.join('spec/fixtures', "#{table_name}.yml"))
      
      rspec_views.each do |action|
        m.template("rspec/views/#{action}_spec.rb",
          File.join('spec/views', controller_class_path, controller_file_name, "#{action}_spec.rb")
        )
      end
      
      unless options[:skip_migration]
        migration_template = RAILS_GEM_VERSION.to_i == 1 ? 'old_migration.rb' : 
        
        m.migration_template('migration.rb', 'db/migrate', 
          :assigns => {
            :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}",
            :attributes     => attributes
          }, 
          :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
        )
      end

      m.route_resources controller_file_name
    end
  end

  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} mwd_scaffold ModelName [field:type, field:type]"
    end

    def scaffold_views
      %w[ index show new edit _form _search ]
    end

    def rspec_views
      %w[ index show new edit ]
    end
    
    def model_name 
      class_name.demodulize
    end
end

module Rails
  module Generator
    class GeneratedAttribute
      def default_value
        @default_value ||= case type
          when :int, :integer then "\"1\""
          when :float then "\"1.5\""
          when :decimal then "\"9.99\""
          when :datetime, :timestamp, :time then "Time.now"
          when :date then "Date.today"
          when :string then "\"MyString\""
          when :text then "\"MyText\""
          when :boolean then "false"
          else
            ""
        end
      end
 
      def input_type
        @input_type ||= case type
          when :text then "textarea"
          else
            "input"
        end
      end
    end
  end
end