class Public::ReportsController < ApplicationController
  before_action :authenticate_poster!
  
  def new
  end
end
