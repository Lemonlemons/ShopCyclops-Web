class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :flag
      t.string :sessionid
      t.string :contents
      t.string :username
      t.string :stream_id
      t.string :host_user_id

      t.timestamps null: false
    end
  end
end
