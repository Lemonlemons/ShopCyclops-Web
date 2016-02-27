class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :lat
      t.float :lng
      t.integer :viewer_id
      t.integer :stream_id
      t.float :taxrate
      t.integer :pricebeforefees
      t.integer :pricebeforetax
      t.integer :totalprice

      t.timestamps null: false
    end
  end
end
