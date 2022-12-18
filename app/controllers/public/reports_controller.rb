class Public::ReportsController < ApplicationController
  before_action :authenticate_poster!

  def new
    @report = Report.new
    @post_photo = PostPhoto.find(params[:post_photo_id])
  end

  def create
    @post_photo = PostPhoto.find(params[:post_photo_id])
    @report = Report.new(report_params)
    @report.post_photo_id = @post_photo.id
    @report.reporter_id = current_poster.id #通報者(reporter_id)にcurrent_user.idを代入
    @report.reported_id = @post_photo.poster.id #通報される人(reported_id)に上で取得した@user.idを代入
     if @report.save
      redirect_to post_photo_path(@post_photo.id), notice: "ご報告ありがとうございます。"
     else
      render "new"
     end
  end

  private

  def report_params
  params.require(:report).permit(:post_photo_id,:reporter_id,:reported_id,:reason)
  end


end
