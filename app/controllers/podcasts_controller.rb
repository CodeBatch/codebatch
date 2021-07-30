class PodcastsController < ApplicationController
  def index
      if params[:search]
        @podcasts = Podcast.search(params[:search]).order("created_at DESC")
      else
        @podcasts = Podcast.all.order('created_at DESC')
      end
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)

    if @podcast.save
      redirect_to @podcast
    else
      render :new
    end
  end

  def edit
    @podcast = Podcast.find(params[:id])
  end

  def update
    @podcast = Podcast.find(params[:id])

    if @podcast.update(podcast_params)
      redirect_to @podcast
    else
      render :edit
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    redirect_to podcasts_path #e.g. Podcasts_path
  end

  def like
    @podcast = Podcast.all.find(params[:id])
    Like.create(user_id: current_user.id, podcast_id: @podcast.id, podcast_path: podcast_url, podcast_title: @podcast.title)
    redirect_to podcast_path(@podcast)
  end

  def unlike
    @podcast = Podcast.all.find(params[:id])
    Like.where(podcast_id: @podcast).destroy_all
    redirect_to podcast_path(@podcast)
  end

  def store
    @podcast = Podcast.all.find(params[:id])
    Store.create(user_id: current_user.id, podcast_id: @podcast.id, podcast_url: podcast_url, podcast_title: @podcast.title)
    redirect_to podcast_path(@podcast)
  end

  def unstore
    @podcast = Podcast.all.find(params[:id])
    Store.where(podcast_id: @podcast).destroy_all
    redirect_to podcast_path(@podcast)
  end

  private
    def podcast_params
      params.require(:podcast).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
