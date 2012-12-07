class AddHandleIndexToAccounts < ActiveRecord::Migration
  def change
    add_index :accounts, :handle
  end
end
