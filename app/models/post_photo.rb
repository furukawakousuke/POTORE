class PostPhoto < ApplicationRecord
  has_one_attached :image
  belongs_to :poster
  has_many :comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :reports ,dependent: :destroy

 validates:address, presence:true
 validates:introduction, presence:true
 validates:image, presence:true
 
  def get_image(height,width)
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io:File.open(file_path),filename: 'default-image.png',content_type: 'image/jpeg')
   end
    image
  end
  
  def favorited_by?(poster)
    favorites.exists?(poster_id: poster.id)
  end
end
