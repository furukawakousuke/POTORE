class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'Poster'
  belongs_to :follower, class_name: 'Poster'
end
