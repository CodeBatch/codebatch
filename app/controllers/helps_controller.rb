class HelpsController < ApplicationController
  def index
      if params[:search]
        @helps = Help.search(params[:search]).order("created_at DESC")
      else
        @helps = Help.all.order('created_at DESC')
      end
  end

  def show
    @help = Help.find(params[:id])
  end

  def new
    @help = Help.new
  end

  def create
    @help = Help.new(Help_params)

    if @help.save
      redirect_to @help
    else
      render :new
    end
  end

  def edit
    @help = Help.find(params[:id])
  end

  def update
    @help = Help.find(params[:id])

    if @help.update(Help_params)
      redirect_to @help
    else
      render :edit
    end
  end

  def destroy
    @help = Help.find(params[:id])
    @help.destroy

    redirect_to Helps_path #e.g. Helps_path
  end

  def like
    @help = Help.all.find(params[:id])
    Like.create(user_id: current_user.id, Help_id: @help.id, Help_path: Help_url, Help_title: @help.title)
    redirect_to Help_path(@help)
  end

  def unlike
    @help = Help.all.find(params[:id])
    Like.where(Help_id: @help).destroy_all
    redirect_to Help_path(@help)
  end

  def store
    @help = Help.all.find(params[:id])
    Store.create(user_id: current_user.id, Help_id: @help.id, Help_url: Help_url, Help_title: @help.title)
    redirect_to Help_path(@help)
  end

  def unstore
    @help = Help.all.find(params[:id])
    Store.where(Help_id: @help).destroy_all
    redirect_to Help_path(@help)
  end

  private
    def Help_params
      params.require(:Help).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
