class ArticlesController < ApplicationController

  skip_before_action :authenticate_user!, :only => [:index, :show]

  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
      if params[:search]
        @articles = Article.search(params[:search]).order("created_at DESC")
      else
        @articles = Article.all.order('created_at DESC')
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

    redirect_to articles_path #e.g. articles_path
  end

  def like
    @article = Article.all.find(params[:id])
    Like.create(user_id: current_user.id, article_id: @article.id, article_path: article_url, article_title: @article.title)
    redirect_to article_path(@article)
  end

  def unlike
    @article = Article.all.find(params[:id])
    Like.where(article_id: @article).destroy_all
    redirect_to article_path(@article)
  end

  def store
    @article = Article.all.find(params[:id])
    Store.create(user_id: current_user.id, article_id: @article.id, article_url: article_url, article_title: @article.title)
    redirect_to article_path(@article)
  end

  def unstore
    @article = Article.all.find(params[:id])
    Store.where(article_id: @article).destroy_all
    redirect_to article_path(@article)
  end

  private
    def article_params
      params.require(:article).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
