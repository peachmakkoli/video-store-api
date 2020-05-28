require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  it "must get index" do
    get videos_path

    must_respond_with :success
    expect(response.header['Content-Type']).must_include 'json'
  end

  it "will return all the proper fields for a list of videos" do
    get videos_path

    body = JSON.parse(response.body)

    expect(body).must_be_instance_of Array

    body.each do |video|
      expect(video).must_be_instance_of Hash
      expect(video.keys.sort).must_equal VIDEO_FIELDS
    end
  end

  it "returns an empty array if no videos exist" do
    Video.destroy_all

    get videos_path

    body = JSON.parse(response.body)

    must_respond_with :success
    expect(body).must_be_instance_of Array
    expect(body.length).must_equal 0
  end

  describe "create" do
    let(:video_data) {
      {
        video: {
          title: "Run for Dream",
          overview: "Chen Yen-Po is a famous Taiwanese ultra-marathon athlete, who became the first ever Asian athlete to complete the 4 Deserts Race Series and achieved the title of World Champion, in 2016. The documentary 'Run for Dream' records Chen Yen-Po’s exciting yet treacherous ten-year journey to become the champion.",
          release_date: "2019-05-27",
          available_inventory: 2
        }
      }
    }

    it "can create a new video" do
      expect {
        post videos_path, params: video_data
      }.must_differ "Video.count", 1

      check_response(expected_type: Hash, expected_status: :created)
    end

    it "will respond with bad_request for invalid data" do
      # Arrange - using let from above
      # Our PetsController test should just test generically
      # for any kind of invalid data, so we will randomly pick
      # the age attribute to invalidate
      video_data[:video][:title] = nil

      expect {
        # Act
        post videos_path, params: video_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
    end

  end
end
