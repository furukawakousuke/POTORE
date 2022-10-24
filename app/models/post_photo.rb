class PostPhoto < ApplicationRecord
  has_one_attached :image
  belongs_to :poster
  has_many :comment,dependent: :destroy
  has_many :favorite,dependent: :destroy
  has_many :report ,dependent: :destroy
end
