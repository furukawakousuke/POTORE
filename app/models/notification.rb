class Notification < ApplicationRecord
  belongs_to :favorite, optional: true
  belongs_to :comment, optional: true

  belongs_to :visitor, class_name: 'Poster', 
  foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'Poster', 
  foreign_key: 'visited_id', optional: true
end
