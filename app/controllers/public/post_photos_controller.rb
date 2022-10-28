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
    @post_photo = PostPhoto.find(params[:id])
  end

  def edit
  end
  def search
  @keyword = "「#{params[:search]}」の検索結果"
  @photos = if params[:search].present?
             PostPhoto.where(['address LIKE ? OR introduction LIKE ?',
                        "%#{params[:search]}%", "%#{params[:search]}%"])
           else
             PostPhoto.none
           end
  end
  
  def update
    @post_photo = PostPhoto.find(params[:id])
    @post_photo = current_poster
    @post_photo.update(post_photo_params)
    redirect_to post_photo_path(@post_photo.id)
  end
  
  def destroy
    @post_photo = PostPhoto.find(params[:id])
    @post_photo.poster_id = current_poster.id
    @post_photo.destroy(post_photo_params)
    redirect_to poster_path(@post_ohoto.id)
  end
end

private

  def post_photo_params
    params.require(:post_photo).permit(:introduction,:address,:image)
  end
