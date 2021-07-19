class DiscussionsController < ApplicationController
  def index
      if params[:search]
        @discussions = Discussion.search(params[:search]).order("created_at DESC")
      else
        @discussions = Discussion.all.order('created_at DESC')
      end
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(Discussion_params)

    if @discussion.save
      redirect_to @discussion
    else
      render :new
    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:id])

    if @discussion.update(Discussion_params)
      redirect_to @discussion
    else
      render :edit
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    @discussion.destroy

    redirect_to Discussions_path #e.g. Discussions_path
  end

  def like
    @discussion = Discussion.all.find(params[:id])
    Like.create(user_id: current_user.id, Discussion_id: @discussion.id, Discussion_path: Discussion_url, Discussion_title: @discussion.title)
    redirect_to Discussion_path(@discussion)
  end

  def unlike
    @discussion = Discussion.all.find(params[:id])
    Like.where(Discussion_id: @discussion).destroy_all
    redirect_to Discussion_path(@discussion)
  end

  def store
    @discussion = Discussion.all.find(params[:id])
    Store.create(user_id: current_user.id, Discussion_id: @discussion.id, Discussion_url: Discussion_url, Discussion_title: @discussion.title)
    redirect_to Discussion_path(@discussion)
  end

  def unstore
    @discussion = Discussion.all.find(params[:id])
    Store.where(Discussion_id: @discussion).destroy_all
    redirect_to Discussion_path(@discussion)
  end

  private
    def Discussion_params
      params.require(:Discussion).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
