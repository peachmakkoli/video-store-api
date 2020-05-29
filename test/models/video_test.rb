require "test_helper"

describe Video do
  describe "validations" do
    before do
      @video = videos(:grand_budapest)
    end

  it "is invalid without a title" do
    @video.title = nil

    result = @video.valid?

    expect(result).must_equal false
    expect(@video.errors.messages).must_include :title
    expect(@video.errors.messages[:title]).must_equal ["can't be blank"]
  end

  it "is invalid without an overview" do
    @video.overview = nil

    result = @video.valid?

    expect(result).must_equal false
    expect(@video.errors.messages).must_include :overview
    expect(@video.errors.messages[:overview]).must_equal ["can't be blank"]
  end

  it "is invalid without a release date" do
    @video.release_date = nil

    result = @video.valid?

    expect(result).must_equal false
    expect(@video.errors.messages).must_include :release_date
    expect(@video.errors.messages[:release_date]).must_equal ["can't be blank"]
  end

  it "is invalid without a total inventory" do
    @video.total_inventory = nil

    result = @video.valid?

    expect(result).must_equal false
    expect(@video.errors.messages).must_include :total_inventory
    expect(@video.errors.messages[:total_inventory]).must_equal ["can't be blank"]
  end

  it "is invalid without an available inventory" do
    @video.available_inventory = nil

    result = @video.valid?

    expect(result).must_equal false
    expect(@video.errors.messages).must_include :available_inventory
    expect(@video.errors.messages[:available_inventory]).must_equal ["can't be blank", "is not a number"]
  end

  end
end
