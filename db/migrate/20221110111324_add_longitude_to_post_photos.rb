class AddLongitudeToPostPhotos < ActiveRecord::Migration[6.1]
  def change
    add_column :post_photos, :longitude, :float
  end
end
