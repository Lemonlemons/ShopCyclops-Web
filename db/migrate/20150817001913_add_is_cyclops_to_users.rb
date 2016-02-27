class AddIsCyclopsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_cyclops, :boolean, default: false
  end
end
