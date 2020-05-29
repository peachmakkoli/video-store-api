class RentalsController < ApplicationController
  def check_in
    # find rental by customer_id and video_id
    rental = Rental.find_by(rental_params)
    # if the rental does not exist
    # render json errors: ["Not Found"] and status :not_found
    # return
    # else
    # decrement rental.customer videos_checked_out_count
    # increment rental.video available_inventory 
    # set due_date to nil
    render json: {
                    customer_id: rental.customer_id, 
                    video_id: rental.video_id, 
                    videos_checked_out_count: rental.customer.videos_checked_out_count, 
                    available_inventory: rental.video.available_inventory
                  }, status: :ok
  end

  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
