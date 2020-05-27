require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "videos_checked_out_count"].sort
  
  describe "index" do
    it "must get index" do
      get customers_path

      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
    end
  end
end
