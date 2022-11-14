class PortfoliosController < ApplicationController
  before_action :upload_data_params, only: %i[synchronize]

  # GET /portfolios
  def index
    @portfolios = Portfolio.all
  end

  # GET /portfolios/upload_data
  def upload_data
    @portfolio = Portfolio.new

    select_by_allowed_states
  end

  # POST /portfolios/synchronize
  def synchronize
    filter = upload_data_params[:filter]
    data = upload_data_params[:data]

    respond_to do |format|
      if data.present? && Actions::DataSynchronizer.extensions_permited.include?(data.content_type)
        if Actions::DataSynchronizer.call({filter: filter, data: data})
          # TODO: render to group with portfolio
          format.html { redirect_to portfolios_path }
        end
      else
        select_by_allowed_states
        format.html {
          redirect_to upload_data_portfolios_path,
          alert: "Unknown file type UploadData."
        }
      end
    end
  end

  private

  def upload_data_params
    params.require(:upload_data).permit(:data, filter: [])
  end

  def select_by_allowed_states
    @states = NodeGroup.states_allowed
  end
end
