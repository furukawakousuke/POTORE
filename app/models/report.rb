class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Poster"
  belongs_to :reported, class_name: "Poster"
  belongs_to :post_photo
  
  
end
