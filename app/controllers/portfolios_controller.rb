class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end
end
