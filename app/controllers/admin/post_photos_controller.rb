class Admin::PostPhotosController < ApplicationController
  def index
    @post_photos = PostPhoto.page(params[:page]).per(10)
  end

  def show
    @post_photo = PostPhoto.find(params[:id])
  end
  
  def destroy
    @post_photo = PostPhoto.find(params[:id])
    @post_photo.destroy
    redirect_to admin_post_photos_path
  end
end
