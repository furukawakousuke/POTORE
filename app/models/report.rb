class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Poster"
  belongs_to :reported, class_name: "Poster"
  belongs_to :post_photo
  
  has_many :notifications,dependent: :destroy
  
  
def update_notification_report!(current_poster, report_id)
	    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
	    temp_ids = Report.select(:poster_id).where(post_photo_id: id).where.not(reported_id: post_photo.poster_id).distinct
	    temp_ids.each do |temp_id|
	        update_notification_report!(post_photo_id,visited_id, temp_id['poster_id'])
       end
    	# まだ誰もコメントしていない場合は、投稿者に通知を送る
    	update_notification_report!(visited_id, post_photo_id) if temp_ids.blank?end

  	  def update_notification_report!(current_poster, report_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = reported.active_notifications.new(
          #reported_id: post_photo.poster_id,
          #post_photo_id: id,
          visited_id: reported_id,
          report_id: report_id,
          action: 'report'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.report_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?end
  
end
