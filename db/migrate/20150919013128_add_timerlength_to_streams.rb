class AddTimerlengthToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :timerlength, :integer
  end
end
