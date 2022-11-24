class Admin::PostPhotosController < ApplicationController
  before_action :authenticate_admin!
  def index
    @post_photos = PostPhoto.order(created_at: :desc).page(params[:page])
  end

  def show
    @post_photo = PostPhoto.find(params[:id])
  end
  
  def destroy
    @post_photo = PostPhoto.find(params[:id])
    @post_photo.destroy
    @post_photo.destroy_notification_post_photo!(current_poster)
    redirect_to admin_post_photos_path
  end
end
