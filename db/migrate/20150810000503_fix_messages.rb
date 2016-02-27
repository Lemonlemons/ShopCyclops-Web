class FixMessages < ActiveRecord::Migration
  def self.up
    remove_column :messages, :sessionid
    remove_column :messages, :host_user_id
    remove_column :messages, :stream_id
    add_column :messages, :user_id, :integer
    add_column :messages, :stream_id, :integer
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end
