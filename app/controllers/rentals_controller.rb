class RentalsController < ApplicationController
  def checkout
    # create new rental
    rental = Rental.new(rental_params)

    customer = Customer.find_by(id: params[:customer_id])
    video = Video.find_by(id: params[:video_id])
    
    if !customer || !video
      render json: {
          errors: ['Not Found']
        }, status: :not_found
        return
    end
        
    if video.available_inventory == 0
      render json: {
          errors: ['Bad Request']
        }, status: :bad_request
      return
    end

    Rental.check_out(rental.customer_id, rental.video_id)
    customer.reload
    video.reload

    rental.due_date = Time.now + 7.days

    if rental.save
      render json: { 
        customer_id: rental.customer_id,
        video_id: rental.video_id,
        due_date: rental.due_date,
        videos_checked_out_count: customer.videos_checked_out_count,
        available_inventory: video.available_inventory
        }, status: :created
      return
    else
      render json: {
          errors: rental.errors.messages
        }, status: :bad_request
      return
    end
  end


  private

  def rental_params
    return params.permit(:customer_id, :video_id)
  end
end
