class RemoveSomeFieldsFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :lat
    remove_column :items, :lng
    remove_column :items, :cardcode
    remove_column :items, :totalprice
    remove_column :items, :uuid
    add_column :orders, :cardcode, :string
  end
end
