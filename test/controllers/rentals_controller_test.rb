require "test_helper"

describe RentalsController do
  CHECKOUT_FIELDS = ["customer_id", "video_id", "due_date", "videos_checked_out_count", "available_inventory"].sort
  CHECKIN_FIELDS = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort

  describe "checkout" do
    let(:rental_data) {
      {
       customer_id: customers(:lee).id,
       video_id: videos(:inception).id
      }
    }

    it "can create a rental with the correct fields when a checkout is made" do
      expect { 
        post checkout_path, params: rental_data 
      }.must_differ "Rental.count", 1
      
      body = check_response(expected_type: Hash, expected_status: :success)

      CHECKOUT_FIELDS.each do |field|
        assert_equal(true, body.has_key?(field))
      end
    end

    it "creates a rental with a due date that is 7 days from the current date" do
      post checkout_path, params: rental_data 

      rental = check_response(expected_type: Hash, expected_status: :success)

      assert_equal((Time.now + 7.days).strftime("%Y-%m-%d"), rental["due_date"])
    end

    it "increments a customer's videos_checked_out_count by 1" do
      expect { 
        post checkout_path, params: rental_data 
        customers(:lee).reload
      }.must_differ "customers(:lee).videos_checked_out_count", 1
    end

    it "decrements a videos's available_inventory by 1" do
      expect { 
        post checkout_path, params: rental_data 
        videos(:inception).reload
      }.must_differ "videos(:inception).available_inventory", -1
    end

    it "returns errors messages and a status 404: Not Found if the customer does not exist" do
      rental_data[:customer_id] = -505

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "return errors messages and a status 404: Not Found if the video does not exist" do
      rental_data[:video_id] = -807

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "returns errors messages and a status 400: Bad Request if the video does not have any available inventory before check out" do
      rental_data[:video_id] = videos(:rested).id

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :bad_request)
    end
  end
  
  describe "checkin" do
    before do
      @customer = customers(:diana)
      @video = videos(:inception)
    end

    let (:rental_data) {
      {
        customer_id: @customer.id,
        video_id: @video.id,
      }
    }
    
    it "can check-in a video for a customer and return all the proper fields" do
      expect {
        post checkin_path, params: rental_data
      }.wont_differ "Rental.count"

      body = check_response(expected_type: Hash, expected_status: :success)

      expect(body.keys.sort).must_equal CHECKIN_FIELDS
    end
    
    it "must decrement the customer videos_checked_out_count" do
      post checkin_path, params: rental_data

      check_response(expected_type: Hash, expected_status: :success)

      @customer.reload
      expect(@customer.videos_checked_out_count).must_equal 0
    end

    it "must increment the video available_inventory count" do
      post checkin_path, params: rental_data

      check_response(expected_type: Hash, expected_status: :success)
      
      @video.reload
      expect(@video.available_inventory).must_equal 5
    end

    it "must set the due_date to nil" do
      post checkin_path, params: rental_data
  
      check_response(expected_type: Hash, expected_status: :success)

      rental = Rental.find_by(rental_data)
      expect(rental.due_date).must_be_nil
    end

    it "must return detailed errors and a status 404 if the customer does not exist" do
      rental_data[:customer_id] = nil
      post checkin_path, params: rental_data

      body = check_response(expected_type: Hash, expected_status: :not_found)

      expect(body['errors']).must_be_instance_of Array
      expect(body['errors'].first).must_equal 'Not Found'
    end

    it "must return detailed errors and a status 404 if the video does not exist" do
      rental_data[:video_id] = nil
      post checkin_path, params: rental_data

      body = check_response(expected_type: Hash, expected_status: :not_found)

      expect(body['errors']).must_be_instance_of Array
      expect(body['errors'].first).must_equal 'Not Found'
    end

    it "must return detailed errors and a status 400 if customer videos_checked_out_count is 0" do
      @customer.update(videos_checked_out_count: 0)

      post checkin_path, params: rental_data

      body = check_response(expected_type: Hash, expected_status: :bad_request)

      expect(body['errors']).must_be_instance_of Array
      expect(body['errors'].first).must_equal 'Customer does not have any videos checked out'
    end
  end
end
