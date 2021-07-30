class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @articles = Article.all.limit(10).order('created_at DESC')
    @videos = Video.all.limit(5).order('created_at DESC')
    @podcasts = Podcast.all.limit(5).order('created_at DESC')
  end

  def show
    @article = Article.find(params[:id])
  end

end
