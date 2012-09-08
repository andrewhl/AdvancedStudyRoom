class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :email
      t.string   :username
      t.integer  :access_level
      t.boolean  :password_reset_flag
      t.datetime :last_signed_in
      t.datetime :last_scraped
      t.float    :points
      t.float    :month_points
      t.float    :lifetime_points
      t.string   :first_name
      t.string   :last_name
      t.string   :password_digest
      t.boolean  :admin
      t.integer  :rank
      t.integer  :kgs_rank
      t.integer  :kaya_rank

      t.timestamps
    end
  end
end
