class AddCartIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :order_id, :integer
    add_column :orders, :is_delivered, :boolean, default: false
  end
end
