class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :account_id
      t.integer :event_id
      t.integer :registration_group_id
      t.float   :total_points, :float, null: false, default: 0
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :registrations, :account_id
    add_index :registrations, :event_id
    add_index :registrations, :registration_group_id
    add_index :registrations, :active
  end
end