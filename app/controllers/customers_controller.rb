class CustomersController < ApplicationController
  def index
    render json: { ok: "it works!" }, status: :ok
  end
end
