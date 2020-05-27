require "test_helper"

describe VideosController do
  VIDEO_INDEX_FIELDS = ["id", "title", "release_date", "available_inventory"].sort
  VIDEO_SHOW_FIELDS = ["title", "overview", "release_date", "total_inventory", "available_inventory"].sort

  describe "index" do
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
        expect(video.keys.sort).must_equal VIDEO_INDEX_FIELDS
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
  end

  describe "show" do
    it "will return a hash with the proper fields for an existing video" do
      video = videos(:inception)

      get video_path(video.id)

      must_respond_with :ok

      body = JSON.parse(response.body)

      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_SHOW_FIELDS
    end

    it "will respond with a 404 status for a non-existent video" do
      get video_path(-1)

      must_respond_with :not_found
      
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end
end
