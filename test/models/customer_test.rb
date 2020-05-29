require "test_helper"

describe Customer do
  before do
    @customer = customers(:lee)
  end

  describe "validations" do
    it "will only allow a number for videos_checked_out_count" do
      @customer.videos_checked_out_count = "zero"

      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :videos_checked_out_count
      expect(@customer.errors.messages[:videos_checked_out_count]).must_equal ["is not a number"]
    end

    it "will only allow a number greater than or equal to 0 for videos_checked_out_count" do
      @customer.videos_checked_out_count = -1

      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :videos_checked_out_count
      expect(@customer.errors.messages[:videos_checked_out_count]).must_equal ["must be greater than or equal to 0"]
    end

    it "will only allow an integer for videos_checked_out_count" do
      @customer.videos_checked_out_count = 1.1

      expect(@customer.valid?).must_equal false
      expect(@customer.errors.messages).must_include :videos_checked_out_count
      expect(@customer.errors.messages[:videos_checked_out_count]).must_equal ["must be an integer"]
    end

    it "will set videos_checked_out_count to 0 by default" do
      new_customer = Customer.create!()

      expect(new_customer.videos_checked_out_count).must_equal 0
    end
  end
end
