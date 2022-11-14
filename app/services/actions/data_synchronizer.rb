module Actions
  class DataSynchronizer < ApplicationService
    def self.extensions_permited
      ["text/csv"]
    end

    def initialize(upload_data)
      raise ArgumentError unless upload_data.is_a?(Hash)

      @upload_data = upload_data
      @data = @upload_data[:data]
    end

    def call
      abstract_class.synchronizer(@upload_data)
    end

    private

    def abstract_class
      return false unless DataSynchronizer.extensions_permited.include?(@data.content_type)

      case @data.content_type
      when "text/csv"
        Actions::Synchronizers::Csv
      end
    end
  end
end
