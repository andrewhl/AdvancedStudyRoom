class CreateServerHandles < ActiveRecord::Migration
  def change
    create_table :server_handles do |t|
      t.integer  :user_id
      t.integer  :server_id
      t.integer  :league_id
      t.string   :handle
      t.integer  :league_tier
      t.integer  :league_active
      t.integer  :rank
      t.integer  :status

      t.timestamps
    end

    add_index :server_handles, :user_id
    add_index :server_handles, :server_id
    add_index :server_handles, :league_id
  end
end