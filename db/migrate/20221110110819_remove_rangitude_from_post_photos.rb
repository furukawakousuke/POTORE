class RemoveRangitudeFromPostPhotos < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_photos, :langitude, :float
  end
end
