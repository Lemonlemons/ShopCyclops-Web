class AddSelectedCardCodeToItems < ActiveRecord::Migration
  def change
    add_column :items, :cardcode, :string
  end
end
