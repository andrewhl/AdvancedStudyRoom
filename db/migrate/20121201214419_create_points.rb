class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :count
      t.integer :account_id
      t.integer :event_id
      t.string :event_desc
      t.string :event_type

      t.timestamps
    end

    add_index :points, :event_type
    add_index :points, :account_id
    add_index :points, :event_id
  end
end
