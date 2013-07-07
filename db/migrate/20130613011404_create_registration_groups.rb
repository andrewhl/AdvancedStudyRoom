class CreateRegistrationGroups < ActiveRecord::Migration
  def change
    create_table :registration_groups do |t|
      t.integer :event_period_id
      t.integer :parent_id
      t.integer :registration_group_type_id
      t.string  :name, limit: 100
      t.integer :min_registrations
      t.integer :max_registrations
      t.integer :position, null: false, default: 1

      t.timestamps
    end

    add_index :registration_groups, :event_period_id
    add_index :registration_groups, :parent_id
  end
end
