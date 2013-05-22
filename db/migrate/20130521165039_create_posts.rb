class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :html
      t.integer :user_id
      t.datetime :date
      t.string :title

      t.timestamps
    end
  end
end
