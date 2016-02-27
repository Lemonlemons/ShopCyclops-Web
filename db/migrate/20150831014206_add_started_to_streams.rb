class AddStartedToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :started, :boolean, default: false
  end
end
