module Actions
  class DataSynchronizer < ApplicationService
    def initialize(filter, upload_data)
      @filter = filter
      @upload_data = upload_data
    end

    def call
    end
  end
end
