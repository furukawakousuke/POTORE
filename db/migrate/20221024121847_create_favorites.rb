class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :poster_id
      t.integer :post_photo_id

      t.timestamps
    end
  end
end
