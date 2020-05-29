require "test_helper"

describe RentalsController do
  CHECK_IN_FIELDS = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort

  describe "check_in" do
    let (:rental_data) {
      {
        customer: customers(:lee),
        video: videos(:inception),
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

    end

    it "must increment the video available_inventory count" do

    end

    it "must set the due_date to nil" do

    end

    it "must return detailed errors and a status 404 if the customer does not exist" do

    end

    it "must return detailed errors and a status 404 if the video does not exist" do

    end
  end
end
