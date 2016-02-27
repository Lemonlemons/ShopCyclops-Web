class AddAdvancedFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :publishable_key, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :access_code, :string
    add_column :users, :reviewpercentage, :integer, default: 100
    add_column :users, :is_admin, :string
  end
end
