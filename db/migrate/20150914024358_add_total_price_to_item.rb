class AddTotalPriceToItem < ActiveRecord::Migration
  def change
    add_column :items, :totalprice, :integer
    remove_column :users, :stripetoken
  end
end
