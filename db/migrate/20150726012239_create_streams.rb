class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :url
      t.integer :host_user_id
      t.integer :number_of_watchers
      t.string :name
      t.string :description
      t.string :store

      t.timestamps null: false
    end
  end
end
