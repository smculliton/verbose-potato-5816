class CustomersController < ApplicationController
  def show 
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.add_item(params[:item_id])

    render "show"
  end
end