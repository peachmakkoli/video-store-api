require "test_helper"

describe RentalsController do
  RENTAL_CHECKOUT_FIELDS = ["customer_id", "video_id", "due_date", "videos_checked_out_count", "available_inventory"].sort

  describe "checkout" do
    before do
      @expected_check_out_rental = {
        "customer_id" => customers(:lee).id,
        "video_id" => videos(:inception).id,
        "due_date" => (Time.now + 7.days).strftime("%Y-%m-%d"),
        "videos_checked_out_count" => customers(:lee).videos_checked_out_count + 1,
        "available_inventory" => videos(:inception).available_inventory - 1
      }
    end

    let(:rental_data) {
      {
       customer_id: customers(:lee).id,
       video_id: videos(:inception).id
      }
    }

    it "can create a rental with the correct information when a checkout is made" do
      expect { 
        post checkout_path, params: rental_data 
      }.must_differ "Rental.count", 1
      
      body = check_response(expected_type: Hash, expected_status: :success)

      assert_equal(@expected_check_out_rental, body)
    end

    it "returns back detailed errors and a status 404: Not Found if the customer does not exist" do
      Customer.destroy_all

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "return back detailed errors and a status 404: Not Found if the video does not exist" do
      Video.destroy_all

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "returns back detailed errors and a status 400: Bad Request if the video does not have any available inventory before check out" do
      rental_data[:video_id] = videos(:rested).id

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :bad_request)
    end
  end
end
