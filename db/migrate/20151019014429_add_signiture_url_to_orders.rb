class AddSignitureUrlToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :signitureurl, :string
  end
end
