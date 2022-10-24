class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :post_photo_id
      t.integer :reporter_id
      t.integer :reported_id
      t.text :reason, null: false

      t.timestamps
    end
  end
end
