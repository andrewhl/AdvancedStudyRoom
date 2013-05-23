class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :email, :string, :null => false, :default => ""

    change_table(:users) do |t|
      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Lockable
      t.integer  :failed_attempts, :default => 0
      t.string   :unlock_token
      t.datetime :locked_at

      ## Token authenticatable
      t.string :authentication_token
    end

    remove_column :users, :password_reset_flag
    remove_column :users, :last_signed_in

    User.all.each do |user|
      t = Time.now
      user.update_attributes({
        confirmation_token: 'a63298d3127d6e68febc2520fda77',
        confirmed_at: t,
        confirmation_sent_at: t }, without_protection: true)
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
