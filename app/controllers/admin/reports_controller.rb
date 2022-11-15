class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reports = Report.page(params[:page]).per(10)
  end
  def show
    @report = Report.find(params[:id])
    @post_photo = @report.post_photo
  end
  def destroy
    @report = Report.find(params[:id])
    @post_photo = @report.post_photo
    if @post_photo.destroy
    redirect_to admin_reports_path
    
    else
      render admin_report_path(@report.id)
    end
  end
end
