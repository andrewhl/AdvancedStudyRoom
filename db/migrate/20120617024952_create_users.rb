class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean  :admin, null: false, default: false
      t.string   :email
      t.string   :username
      t.string   :password_digest
      t.boolean  :password_reset_flag
      t.datetime :last_signed_in
      t.string   :first_name
      t.string   :last_name

      t.timestamps
    end
  end
end
