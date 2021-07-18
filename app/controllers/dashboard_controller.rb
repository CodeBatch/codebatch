class DashboardController < ApplicationController

  def index
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC")
    else
      @articles = Article.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def stats
    @likes = Like.where(user_id: current_user.id)
    @stores = Store.where(user_id: current_user.id)
  end

  def articles
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC")
    else
      @articles = Article.where(user_id: current_user.id).order('created_at DESC')
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path #e.g. articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :user_id, :user_email, :search)
    end
end
