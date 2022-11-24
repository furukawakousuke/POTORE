class Admin::PostersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posters = Poster.order(created_at: :desc).page(params[:page])
  end

  def show
    @poster = Poster.find(params[:id])
  end
end
