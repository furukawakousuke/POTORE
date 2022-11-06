class Poster < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_one_attached :profile_image

  has_many :post_photos,dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: :following_id,
  dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship',
  foreign_key: :follower_id,dependent: :destroy
  has_many :followers, through: :relationships, source: :follower
  has_many :followings, through: :reverse_of_relationships, source: :following
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :active_notifications, class_name: 'Notification',
  foreign_key: :visitor_id, dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification',
  foreign_key: :visited_id, dependent: :destroy
  has_many :reports, class_name: "Report",
  foreign_key: :reporter_id, dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report",
  foreign_key: :reported_id, dependent: :destroy

    def self.guest
    find_or_create_by!(email: 'guest@example.com') do |poster|
      poster.password = SecureRandom.urlsafe_base64
      poster.user_name = "@guest"
      # poster.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
      end
    end

   def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
   end

  def get_image(height,width)
   unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     profile_image.attach(io:File.open(file_path),filename: 'default-image.png',content_type: 'image/jpeg')
   end
    profile_image
  end

# フォローしたときの処理
def follow(poster_id)
  relationships.create(follower_id: poster_id)
end
# フォローを外すときの処理
def unfollow(poster_id)
  relationships.find_by(follower_id: poster_id).destroy
end
# フォローしているか判定
def following?(poster)
  
  pp "-------------------------------------------"
  pp poster
  pp "--------------------------------------------"
  followers.include?(poster)
end

 def create_notification_follow!(current_poster)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_poster.id, id, 'follow'])
    if temp.blank?
      notification = current_poster.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
 end


end
