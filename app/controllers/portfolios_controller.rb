class PortfoliosController < ApplicationController
  before_action :upload_data_params, only: %i[synchronize]

  # GET /portfolios
  def index
    # TODO: refactor index, change to scopes model
    prepare_form
    if filter_params.present?
      filter_year, filter_state = filter_params.values

      @result_year_group = NodeGroup.find_by(id: filter_year, kind: NodeGroup.kinds['year'])
      @result_state_group = NodeGroup
        .where(ancestry: @result_year_group, kind: NodeGroup.kinds['state'])
        .find_by(id: filter_state)
    else
      maximum_slug = NodeGroup.where(kind: NodeGroup.kinds['year']).maximum(:slug)
      @result_year_group = NodeGroup
        .where(kind: NodeGroup.kinds['year'])
        .find_by(slug: maximum_slug)
      @result_state_group = @result_year_group&.children&.order(:slug)&.min
    end

    @portfolios = Portfolio.where(node_group: @result_state_group).order(expenses_amount_cents: :desc)
  end

  # GET /portfolios/upload_data
  def upload_data
    @portfolio = Portfolio.new

    select_by_allowed_states
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

  def filter_params
    params.require(:filter).permit(:year_id, :state_id) if params['filter']
  end

  def select_by_allowed_states
    @states = NodeGroup.states_allowed
  end


  def prepare_form
    @year_groups = NodeGroup.where(kind: NodeGroup.kinds['year']).order(:slug).pluck(:slug, :id)
  end
end
