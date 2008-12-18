module MwdScaffoldCoreExtensions
  module ActionView
    module Base

      #override the native link_to to allow us to use wrap_in
      def link_to(name, path_options = {}, html_options = {}, *params, &block)  
        result = html_options.delete(:show_text) ? name : ""

        wrap_tag = html_options.delete(:wrap_in)
        result = super( name, path_options, html_options, *params )

        # TODO: when generating wrapped links this does not allow you to style the wrapper
        result = content_tag(wrap_tag, result) if wrap_tag != nil    
        result   
      end

      #wrapper for flash messages container
      def show_flash
        out = ''
        flash.each do |msg|
          out += "<div class='flash_#{msg[0].to_s}'>"+flash[msg[0].to_sym]+"</div>"
        end
        out
      end
            
      def object_show_link(object, label=:icon)
        case label
        when :icon
          label = render(:partial=>'/shared/icon_show')
        when :name
          label = object.name          
        when :text
          label = 'show'        
        end
        
        link_to label, object_url(object)
      end

      def object_edit_link(object, label=:icon)
        case label
        when :icon
          label = render(:partial=>'/shared/icon_edit')
        when :name
          label = object.name          
        when :text
          label = 'edit'        
        end
        
        link_to label, edit_object_url(object)
      end

      def object_state_link(object, label=:icon)
        if object.active?
          case label
          when :icon
            label = render(:partial=>'/shared/icon_deactivate')
          when :name
            label = object.name          
          when :text
            label = 'deactivate'        
          end
          url = object_url(object)+'/suspend'
          confirm = "Are you sure you want to deactivate this #{object.class.to_s}?"
        else
          case label
          when :icon
            label = render(:partial=>'/shared/icon_activate')
          when :name
            label = object.name          
          when :text
            label = 'activate'        
          end
          url = object_url(object)+'/activate'
          confirm = "Are you sure you want to activate this #{object.class.to_s}?"
        end

        link_to label, url, :confirm => confirm, :method => :put
      end
      
      def object_destroy_link(object, label=:icon)
        case label
        when :icon
          label = render(:partial=>'/shared/icon_delete')
        when :name
          label = object.name          
        when :text
          label = 'delete'        
        end
        
        link_to label, object_url(object), :confirm=>"Are you sure you wish to delete this #{object.class.to_s}?", :method=>:delete  
      end
      
      private
            
    end
  end
end