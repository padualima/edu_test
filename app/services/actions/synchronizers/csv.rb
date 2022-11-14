require 'csv'

module Actions
  module Synchronizers
    class Csv < Base
      def parse_data
        @log.info("Start parser data")
        csv = CSV.foreach(
          @data.path,
          headers: true,
          col_sep: ';',
          header_converters: :symbol,
          liberal_parsing: true
        ).map(&:to_h)

        if @filter.any?
          @log.info("filtering the data")
          csv.delete_if { |row| !@filter.include?(row[:sguf]) }
        end

        @data = csv
        @log.info("Parser data finished")
      end
    end
  end
end
