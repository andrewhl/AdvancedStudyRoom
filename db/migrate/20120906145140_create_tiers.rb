class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.string  :name
      t.integer :index
      t.integer :event_id

      t.timestamps
    end

    add_index :tiers, :index
    add_index :tiers, :event_id
  end
end