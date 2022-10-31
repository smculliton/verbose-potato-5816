class SupermarketsController < ApplicationController
  def show
    @market = Supermarket.find(params[:id])
    @customers = @market.customers
  end
end