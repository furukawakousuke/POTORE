class Admin::PostersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posters = Poster.page(params[:page]).per(10)
  end

  def show
    @poster = Poster.find(params[:id])
  end
end
