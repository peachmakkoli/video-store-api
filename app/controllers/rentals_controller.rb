class RentalsController < ApplicationController
  def check_in
    rental = Rental.find_by(rental_params)

    if !rental
      render json: {
        errors: ['Not Found']
      }, status: :not_found
      return
    end
    
    customer = rental.customer
    video = rental.video
    if customer.videos_checked_out_count <= 0
      render json: {
        errors: ['Customer does not have any videos checked out']
      }, status: :bad_request
      return
    else
      rental.check_in
      customer.reload
      video.reload

      render json: {
                      customer_id: customer.id, 
                      video_id: video.id, 
                      videos_checked_out_count: customer.videos_checked_out_count, 
                      available_inventory: video.available_inventory
                    }, status: :ok
    end
  end

  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
