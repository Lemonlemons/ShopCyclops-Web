class ChangeSteamIdToStreamId < ActiveRecord::Migration
  def change
    remove_column :items, :steam_id
    add_column :items, :stream_id, :integer
  end
end
