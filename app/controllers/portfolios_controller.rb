class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[show]
  before_action :prepare_filter, only: %i[index]
  before_action :select_states_form_filter, only: %i[index]
  before_action :prepare_form, only: %i[upload_data]

  # GET /portfolios
  def index
    @portfolios = Portfolio.find_by_group(@y_group, @s_group)
  end

  # GET /portfolios/:id
  def show; end

  # GET /portfolios/upload_data
  def upload_data
    @portfolio = Portfolio.new
  end

  # POST /portfolios/synchronize
  def synchronize
    filter = upload_data_params[:filter].delete_if { |f| f.empty? }
    data = upload_data_params[:data]

    respond_to do |format|
      if data.present? && Actions::DataSynchronizer.extensions_permited.include?(data.content_type)
        if Actions::DataSynchronizer.call({filter: filter, data: data})
          format.html { redirect_to portfolios_path }
        end
      else
        format.html {
          redirect_to upload_data_portfolios_path,
          alert: "O arquivo enviado, não é de um tipo de arquivo aceito!"
        }
      end
    end
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def upload_data_params
    params.require(:upload_data).permit(:data, filter: [])
  end

  def filter_params
    params.require(:filter).permit(:year_id, :state_id) if params['filter']
  end

  def get_state_by_oldest_year
    state_group = NodeGroup.states_by_year(NodeGroup.oldest_year&.id).order(:slug).first
    [state_group&.parent&.id, state_group&.id]
  end

  def prepare_filter
    @y_group, @s_group = filter_params.present? ? filter_params.values : get_state_by_oldest_year
  end

  def prepare_form
    select_by_allowed_states
    @root_toggle = true if Portfolio.count.positive?
  end

  def select_by_allowed_states
    @select_by_allowed_states = NodeGroup.states_allowed
  end

  def select_states_form_filter
    @select_states_form_filter = NodeGroup.by_years.order(:slug).pluck(:slug, :id)
  end
end
