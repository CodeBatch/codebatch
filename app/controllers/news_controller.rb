class NewsController < ApplicationController
  def index
      if params[:search]
        @news = News.search(params[:search]).order("created_at DESC")
      else
        @news = News.all.order('created_at DESC')
      end
  end

  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(News_params)

    if @news.save
      redirect_to @news
    else
      render :new
    end
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    @news = News.find(params[:id])

    if @news.update(News_params)
      redirect_to @news
    else
      render :edit
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy

    redirect_to Newss_path #e.g. Newss_path
  end

  def like
    @news = News.all.find(params[:id])
    Like.create(user_id: current_user.id, News_id: @news.id, News_path: News_url, News_title: @news.title)
    redirect_to News_path(@news)
  end

  def unlike
    @news = News.all.find(params[:id])
    Like.where(News_id: @news).destroy_all
    redirect_to News_path(@news)
  end

  def store
    @news = News.all.find(params[:id])
    Store.create(user_id: current_user.id, News_id: @news.id, News_url: News_url, News_title: @news.title)
    redirect_to News_path(@news)
  end

  def unstore
    @news = News.all.find(params[:id])
    Store.where(News_id: @news).destroy_all
    redirect_to News_path(@news)
  end

  private
    def News_params
      params.require(:News).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
