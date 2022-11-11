class Admin::PostersController < ApplicationController
  def index
    @posters = Poster.page(params[:page]).per(10)
  end

  def show
    @poster = Poster.find(params[:id])
  end
end
