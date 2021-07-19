class ListingsController < ApplicationController
  def index
      if params[:search]
        @listings = Listing.search(params[:search]).order("created_at DESC")
      else
        @listings = Listing.all.order('created_at DESC')
      end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(Listing_params)

    if @listing.save
      redirect_to @listing
    else
      render :new
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])

    if @listing.update(Listing_params)
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy

    redirect_to Listings_path #e.g. Listings_path
  end

  def like
    @listing = Listing.all.find(params[:id])
    Like.create(user_id: current_user.id, Listing_id: @listing.id, Listing_path: Listing_url, Listing_title: @listing.title)
    redirect_to Listing_path(@listing)
  end

  def unlike
    @listing = Listing.all.find(params[:id])
    Like.where(Listing_id: @listing).destroy_all
    redirect_to Listing_path(@listing)
  end

  def store
    @listing = Listing.all.find(params[:id])
    Store.create(user_id: current_user.id, Listing_id: @listing.id, Listing_url: Listing_url, Listing_title: @listing.title)
    redirect_to Listing_path(@listing)
  end

  def unstore
    @listing = Listing.all.find(params[:id])
    Store.where(Listing_id: @listing).destroy_all
    redirect_to Listing_path(@listing)
  end

  private
    def Listing_params
      params.require(:Listing).permit(:title, :description, :body, :status, :user_id, :user_email, :search)
    end
end
