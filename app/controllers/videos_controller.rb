class VideosController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  def index
    @videos = Video.all
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to @video
    else
      render :new
    end
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])

    if @video.update(video_params)
      redirect_to @video
    else
      render :edit
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy

    redirect_to root_path
  end

  def video_like
    @video = Video.all.find(params[:id])
    Video_Like.create(user_id: current_user.id, video_id: @video.id, video_path: video_url, video_title: @video.title)
    redirect_to video_path(@video)
  end

  def video_unlike
    @video = Video.all.find(params[:id])
    Video_Like.where(video_id: @video).destroy_all
    redirect_to video_path(@video)
  end

  private
    def video_params
      params.require(:video).permit(:title,:body,:status)
    end

end
