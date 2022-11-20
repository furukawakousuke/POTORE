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
    if @report.destroy
    redirect_to admin_reports_path
    
    else
      render admin_report_path(@report.id)
    end
  end
  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      
      redirect_to admin_reports_path
    else
      render admin_report_path(@report.id)
    end
  end
  
  private
  def report_params
    params.require(:report).permit(:reason)
  end
  
end
