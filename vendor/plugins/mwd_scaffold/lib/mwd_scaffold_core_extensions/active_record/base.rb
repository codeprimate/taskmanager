module MwdScaffoldCoreExtensions
  module ActiveRecord
    module Base
      

      ######################################################################
      # CSV export functionality
      ######################################################################

      # add the ability to convert activerecord to CSV - requires FasterCSV
      def self.to_csv(*args)
        find(:all).to_csv(*args)
      end

      # redefine this method in your model to tailor what fields are exported to CSV
      # def export_columns(format = nil)
      #   case format
      #   when :local
      #     %w[name_last name_first login email]
      #   else
      #     %w[name_last name_first login email]
      #   end
      # end
      def export_columns(format = nil)
        self.class.content_columns.map(&:name) - ['created_at', 'updated_at']
      end

      def to_row(format = nil)
        export_columns(format).map { |c| self.send(c) }
      end

      ######################################################################
   
    end
  end
end
