class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :user_id
      t.integer :achievement_id
      t.datetime :date_awarded

      t.timestamps
    end

    add_index :awards, :user_id
    add_index :awards, :achievement_id
  end
end
