class PortfoliosController < ApplicationController

  # GET /portfolios
  def index
    @portfolios = Portfolio.all
  end

  # GET /portfolios/upload_data
  def upload_data
    @portfolio = Portfolio.new

    select_by_allowed_states
  end

  private

  def select_by_allowed_states
    @states = NodeGroup.states_allowed
  end
end
