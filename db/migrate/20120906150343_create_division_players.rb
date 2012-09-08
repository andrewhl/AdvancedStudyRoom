class CreateDivisionPlayers < ActiveRecord::Migration
  def change
    create_table :division_players do |t|
      t.integer :division_id
      t.integer :kgs_handle_id
      t.float :points
      t.integer :status

      t.timestamps
    end

    add_index :division_players, :kgs_handle_id
    add_index :division_players, :division_id
  end
end
