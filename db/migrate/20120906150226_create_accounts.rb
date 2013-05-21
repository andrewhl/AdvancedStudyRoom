class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string   :handle
      t.integer  :user_id
      t.integer  :server_id
      t.integer  :rank
      t.boolean  :active, null: false, default: true

      t.timestamps
    end

    add_index :accounts, :user_id
    add_index :accounts, :active
    add_index :accounts, :server_id
    add_index :accounts, :handle
  end
end

