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
    @podcast = Podcast.new(Podcast_params)

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

    if @podcast.update(Podcast_params)
      redirect_to @podcast
    else
      render :edit
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    redirect_to Podcasts_path #e.g. Podcasts_path
  end

  def like
    @podcast = Podcast.all.find(params[:id])
    Like.create(user_id: current_user.id, Podcast_id: @podcast.id, Podcast_path: Podcast_url, Podcast_title: @podcast.title)
    redirect_to Podcast_path(@podcast)
  end

  def unlike
    @podcast = Podcast.all.find(params[:id])
    Like.where(Podcast_id: @podcast).destroy_all
    redirect_to Podcast_path(@podcast)
  end

  def store
    @podcast = Podcast.all.find(params[:id])
    Store.create(user_id: current_user.id, Podcast_id: @podcast.id, Podcast_url: Podcast_url, Podcast_title: @podcast.title)
    redirect_to Podcast_path(@podcast)
  end

  def unstore
    @podcast = Podcast.all.find(params[:id])
    Store.where(Podcast_id: @podcast).destroy_all
    redirect_to Podcast_path(@podcast)
  end

  private
    def Podcast_params
      params.require(:Podcast).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
