class Favorite < ApplicationRecord
  belongs_to :poster
  belongs_to :post_photo
  has_many :notifications,dependent: :destroy
  
  
  
end
