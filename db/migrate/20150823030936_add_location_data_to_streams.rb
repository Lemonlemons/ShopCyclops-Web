class AddLocationDataToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :lat, :float
    add_column :streams, :lng, :float
  end
end
