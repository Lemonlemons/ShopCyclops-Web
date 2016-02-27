class AddUuidToItems < ActiveRecord::Migration
  def change
    remove_column :items, :streamer_id
    add_column :items, :uuid, :string
  end
end
