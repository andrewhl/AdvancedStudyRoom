class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer  :user_id
      t.integer  :server_id
      t.integer  :event_id
      t.string   :handle
      t.integer  :league_tier
      t.integer  :league_active
      t.integer  :rank
      t.integer  :status
      t.integer  :division_id

      t.timestamps
    end

    add_index :accounts, :user_id
    add_index :accounts, :server_id
    add_index :accounts, :event_id
    add_index :accounts, :division_id
    add_index :accounts, :handle
  end
end

