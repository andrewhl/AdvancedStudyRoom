class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float   :count
      t.integer :account_id
      t.integer :event_id
      t.string  :event_desc
      t.string  :event_type
      t.integer :registration_id
      t.boolean :enabled
      t.integer :match_id

      t.timestamps
    end

    add_index :points, :event_type
    add_index :points, :account_id
    add_index :points, :event_id
    add_index :points, :match_id
  end
end