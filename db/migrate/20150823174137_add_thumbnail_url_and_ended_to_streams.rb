class AddThumbnailUrlAndEndedToStreams < ActiveRecord::Migration
  def change
    add_column :streams, :ended, :boolean, default: false
    add_column :streams, :thumbnail_url, :string
  end
end
