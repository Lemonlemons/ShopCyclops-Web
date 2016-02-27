class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :contents
      t.float :price
      t.integer :quantity
      t.string :status
      t.string :imageurl
      t.integer :progress
      t.integer :steam_id
      t.integer :streamer_id
      t.integer :viewer_id

      t.timestamps null: false
    end
  end
end
