class AddPostPhotoIdToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :post_photo_id, :integer
  end
end
