class VideosController < ApplicationController
  def index
    videos = Video.all.order(:title)

    render json: videos.as_json(only: [:id, :title, :release_date, :available_inventory]),
                                status: :ok
  end

  def show
  end
end
