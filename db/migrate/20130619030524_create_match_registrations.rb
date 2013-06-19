class CreateMatchRegistrations < ActiveRecord::Migration
  def change
    create_table :match_registrations do |t|
      t.integer :match_id
      t.integer :registration_id
      t.boolean :white
      t.boolean :black
      t.boolean :winner
      t.boolean :loser

      t.timestamps
    end

    add_index :match_registrations, :winner
    add_index :match_registrations, :loser
    add_index :match_registrations, :match_id
  end
end
