class AddProgressToStreams < ActiveRecord::Migration
  def change
    remove_column :streams, :ended
    remove_column :streams, :started
    add_column :streams, :progress, :integer, default: 1
  end
end
