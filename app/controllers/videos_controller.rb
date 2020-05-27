class VideosController < ApplicationController
  def index
    videos = Video.all.order(:title)

    render json: videos.as_json(only: [:id, :title, :release_date, :available_inventory]),
                                status: :ok
  end

  def show
    video = Video.find_by(id: params[:id])

    if !video
      render json: {
        ok: false,
        message: "Not found"
      }, status: :not_found
    end
  end
end
