class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :account_id
      t.integer :event_id
      t.integer :division_id
      t.float   :points_this_month
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    add_index :registrations, :account_id
    add_index :registrations, :event_id
    add_index :registrations, :division_id
    add_index :registrations, :active
  end
end
