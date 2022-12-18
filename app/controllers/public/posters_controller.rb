class Public::PostersController < ApplicationController
  before_action :authenticate_poster!
  before_action :specified_posters, only: [:edit,:update] 

  def index
    @user = Poster.all.shuffle
  end

  def show
    @poster = Poster.find(params[:id])
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
  
  def specified_posters
    @poster = Poster.find(params[:id])
    redirect_to poster_path(current_poster.id) unless @poster.id == current_poster.id 
  end