class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
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

    add_index :accounts, :user_id
    add_index :accounts, :server_id
    add_index :accounts, :league_id
  end
end