class Public::PostersController < ApplicationController
  before_action :authenticate_poster!

  def index
      @keyword =  "#{params[:search]}"
      @posters = if params[:search].present?
      Poster.where(['name LIKE ? OR user_name LIKE ?', "%#{params[:search]}%","%#{params[:search]}%"])
    else
      Poster.all.shuffle
    end
    @user = Poster.all.shuffle
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

  def search
    @keyword =  "#{params[:search]}"
    @posters = if params[:search].present?
      Poster.where(['name LIKE ? OR user_name LIKE ?', "%#{params[:search]}%","%#{params[:search]}%"])
    else
      Poster.all
    end
  end
  
  def favorites
    @poster = Poster.find(params[:id])
    favorites = Favorite.where(poster_id: @poster.id).pluck(:post_photo_id)
    @favorite_posts = PostPhoto.find(favorites)
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