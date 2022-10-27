class Public::PostersController < ApplicationController
  def index
  end

  def show
    @poster = Poster.find(params[:id])
    @posters = Poster.all
    @post_photo = PostPhoto.find(params[:id])
  end

  def edit
  end
  def update
    
  end
end
