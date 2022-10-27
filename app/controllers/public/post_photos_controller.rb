class Public::PostPhotosController < ApplicationController
  def new
    @post_photo = PostPhoto.new
  end

  def create
    @post_photo = PostPhoto.new(post_photo_params)
    @post_photo.poster_id = current_poster.id
    if @post_photo.save
      redirect_to post_photos_path
    else
      render :new
    end
  end

  def index
    @post_photos = PostPhoto.all
  end

  def show
  end

  def edit
  end
  def search
    if params[:keyword].present?
      @photos = PostPhoto.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @photos = PostPhoto.all
    end
  end
end

private

  def post_photo_params
    params.require(:post_photo).permit(:introduction,:address,:image)
  end
