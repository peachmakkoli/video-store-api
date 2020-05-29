require "test_helper"

describe RentalsController do
  CHECK_IN_FIELDS = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort

  describe "check_in" do
    it "must return all the proper fields for a rental check-in" do
      
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
