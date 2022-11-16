module Public::NotificationsHelper

  def notification_form(notification)
	  @visitor = notification.visitor
	  @comment = nil
	  your_post_photo = link_to 'あなたの投稿', post_photo_path(notification), style:"font-weight: bold;"
	  @visitor_comment = notification.comment_id
	  #notification.actionがfollowかlikeかcommentか
	  case notification.action
	    when "follow" then
	      tag.a(notification.visitor.name, href:poster_path(@visitor), style:"font-weight: bold;")+"があなたをフォローしました"
	    when "favorite" then
	      tag.a(notification.visitor.name, href:poster_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_photo_path(notification.post_photo_id), style:"font-weight: bold;")+"にいいねしました"
	    when "comment" then
	    	@comment = Comment.find_by(id: @visitor_comment)&.text
	    	tag.a(@visitor.name, href:poster_path(@visitor), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_photo_path(notification.post_photo_id), style:"font-weight: bold;")+"にコメントしました"
	    when "post_photo" then
	    	"報告を受け、管理者側から投稿写真を削除されました。"
	  end
  end
  def unchecked_notifications
    @notifications = current_poster.passive_notifications.where(checked: false)
  end


end
