class Public::PostPhotosController < ApplicationController
  before_action :authenticate_poster!
  before_action :specified_post_photo, only: [:edit, :update]
  before_action :specified_poster, only: [:edit] 

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
    @post_photos = PostPhoto.order(created_at: :desc).page(params[:page])
  end

  def show
    @post_photo = PostPhoto.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post_photo = PostPhoto.find(params[:id])

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
    @post_photo.update(post_photo_params)
    redirect_to post_photo_path(@post_photo.id)
  end

  def destroy
    @post_photo = PostPhoto.find(params[:id])
    @post_photo.poster_id = current_poster.id
    @post_photo.destroy
    redirect_to current_poster
  end
end

private

  def post_photo_params
    params.require(:post_photo).permit(:introduction,:address,:longitude,
    :latitude,:image)
  end
  
  def specified_post_photo
    @post_photo = PostPhoto.find(params[:id])
  end
  
  def specified_poster
    redirect_to post_photos_path unless @post_photo.poster_id == current_poster.id 
  end
