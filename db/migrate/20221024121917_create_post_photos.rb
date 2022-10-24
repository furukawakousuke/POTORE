class CreatePostPhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :post_photos do |t|
      t.integer :poster_id
      t.text :introduction
      t.string :address
      t.float :latitude
      t.float :langitude
      t.timestamps
    end
  end
end
