require "test_helper"

describe Rental do
  before do
    @rental = rentals(:rental)
  end 
  
  describe "validations" do
    it "must have a customer_id" do
      @rental.customer_id = nil

      expect(@rental.valid?).must_equal false
      expect(@rental.errors.messages).must_include :customer_id
      expect(@rental.errors.messages[:customer_id]).must_equal ["can't be blank"]
    end

    it "must have a video_id" do
      @rental.video_id = nil

      expect(@rental.valid?).must_equal false
      expect(@rental.errors.messages).must_include :video_id
      expect(@rental.errors.messages[:video_id]).must_equal ["can't be blank"]
    end
  end
end
