require "fastercsv"

module MwdScaffoldCoreExtensions
  module Array

    # add the ability to convert array to CSV - requires FasterCSV
    def to_csv(options = {})
      if all? { |e| e.respond_to?(:to_row) }
        header_row = first.export_columns(options[:format]).to_csv unless first.nil?
        content_rows = map { |e| e.to_row(options[:format]) }.map(&:to_csv)
        ([header_row] + content_rows).join
      else
        FasterCSV.generate_line(self, options)
      end
    end

  end
end
