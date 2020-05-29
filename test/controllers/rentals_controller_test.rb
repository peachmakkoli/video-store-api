require "test_helper"

describe RentalsController do
  CHECK_IN_FIELDS = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort

  describe "check_in" do
    before do
      @customer = customers(:diana)
      @video = videos(:inception)
    end

    let (:rental_data) {
      {
        customer: @customer,
        video: @video,
      }
    }
    
    it "can check-in a video for a customer and return all the proper fields" do
      expect {
        post check_in_path, params: rental_data
      }.wont_differ "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :success)

      expect(body.keys.sort).must_equal CHECK_IN_FIELDS
    end
    
    it "must decrement the customer videos_checked_out_count" do
      post check_in_path, params: rental_data

      check_response(expected_type: Hash, expected_status: :success)

      expect(@customer.videos_checked_out_count).must_equal 0
    end

    it "must increment the video available_inventory count" do
      post check_in_path, params: rental_data

      check_response(expected_type: Hash, expected_status: :success)

      expect(@video.available_inventory).must_equal 5
    end

    it "must set the due_date to nil" do
      post check_in_path, params: rental_data
  
      check_response(expected_type: Hash, expected_status: :success)

      rental = Rental.find_by(rental_data)
      expect(rental.due_date).must_be_nil
    end

    it "must return detailed errors and a status 404 if the customer does not exist" do
      rental_data[:customer] = nil
      post check_in_path, params: rental_data

      body = check_response(expected_type: Hash, expected_status: :not_found)

      expect(body['errors']).must_be_instance_of Array
      expect(body['errors'].first).must_equal 'Not Found'
    end

    it "must return detailed errors and a status 404 if the video does not exist" do
      rental_data[:video] = nil
      post check_in_path, params: rental_data

      body = check_response(expected_type: Hash, expected_status: :not_found)

      expect(body['errors']).must_be_instance_of Array
      expect(body['errors'].first).must_equal 'Not Found'
    end
  end
end
