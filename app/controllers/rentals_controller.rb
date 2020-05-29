class RentalsController < ApplicationController
  def check_in
    rental = Rental.find_by(rental_params)

    if !rental
      render json: {
        errors: ['Not Found']
      }, status: :not_found
      return
    else
      Customer.decrement_counter(:videos_checked_out_count, rental.customer_id, touch: true)
      Video.increment_counter(:available_inventory, rental.video_id, touch: true)
      rental.update(due_date: nil)

      render json: {
                      customer_id: rental.customer_id, 
                      video_id: rental.video_id, 
                      videos_checked_out_count: rental.customer.videos_checked_out_count, 
                      available_inventory: rental.video.available_inventory
                    }, status: :ok
    end
  end

  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
