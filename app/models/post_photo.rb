class PostPhoto < ApplicationRecord
  has_one_attached :image
  belongs_to :poster
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  
  has_many :reports ,dependent: :destroy
  has_many :notifications,dependent: :destroy
 validates:address, presence:true
 validates:introduction, presence:true
 validates:image, presence:true

  def get_image
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io:File.open(file_path),filename: 'default-image.png',content_type: 'image/jpeg')

   end
    image
  end
  # いいねの記述
    def favorited_by?(poster)
    favorites.exists?(poster_id: poster.id)
    end

    def create_notification_by(current_poster)
	    notification = current_poster.active_notifications.new(
	      post_photo_id: id,
	      visited_id: poster_id,
	      action: "favorite"
	    )
	    notification.save if notification.valid?
    end

  	def create_notification_comment!(current_poster, comment_id)
	    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
	    temp_ids = Comment.select(:poster_id).where(post_photo_id: id).where.not(poster_id: current_poster.id).distinct
	    temp_ids.each do |temp_id|
	        save_notification_comment!(current_poster, comment_id, temp_id['poster_id'])
       end
    	# まだ誰もコメントしていない場合は、投稿者に通知を送る
    	save_notification_comment!(current_poster, comment_id, poster_id) if temp_ids.blank?end

  	  def save_notification_comment!(current_poster, comment_id, visited_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_poster.active_notifications.new(
          post_photo_id: id,
          comment_id: comment_id,
          visited_id: visited_id,
          action: 'comment'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?end

      geocoded_by :address
      after_validation :geocode,if: :address_changed?


      #管理側からの削除通知
     def destroy_notification_post_photo!(current_poster)
       temp = Notification.where(["visited_id = ? and post_photo_id = ? and action = ? ",
                                  poster_id, id, 'post_photo'])
       if temp.blank?
          notification = poster.active_notifications.new(
            post_photo_id: id,
            visited_id: poster_id,
            action: 'post_photo'
          )

        if notification.post_photo_id == notification.visited_id
         notification.checked = true
        end
        notification.save if notification.valid?
       end
     end

end
