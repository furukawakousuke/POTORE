class Public::PostersController < ApplicationController
  before_action :authenticate_poster!

  def index
      @keyword =  "#{params[:keyward]}"
    @posters = if params[:keyword].present?
      Poster.where(['name LIKE ? OR user_name LIKE ?', "%#{params[:keyword]}%","%#{params[:keyward]}%"])
    else
      Poster.all
    end
  end

  def show
    @poster = Poster.find(params[:id])
    @posters = Poster.all
    #@post_photo = PostPhoto.find(params[:id])
    #@following_poster = @poster.followings
    #@follower_poster = @poster.follower_poster
  end

  def edit
    @poster = Poster.find(params[:id])
  end
  def update
   @poster = Poster.find(params[:id])
   @poster.update(poster_params)
   redirect_to poster_path(@poster.id)
  end
end

private
  def poster_params
  params.require(:poster).permit(:name,:introduction,:user_name,:email,:profile_image)
  end