class CustomersController < ApplicationController
  def index
    customers = Customer.order(:name)

    render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone, :videos_checked_out_count]), 
           status: :ok
  end
end
