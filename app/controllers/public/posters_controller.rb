class Public::PostersController < ApplicationController
  def index
  end

  def show
    @poster = Poster.find(params[:id])
    @posters = Poster.all
    @post_photo = PostPhoto.find(params[:id])
    #@following_poster = @poster.followings
    #@follower_poster = @poster.follower_poster
  end

  def edit
  end
  def update

  end
end
