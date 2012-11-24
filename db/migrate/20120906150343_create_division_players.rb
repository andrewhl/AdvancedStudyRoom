class CreateDivisionPlayers < ActiveRecord::Migration
  def change
    create_table :division_players do |t|
      t.integer :division_id
      t.integer :account_id
      t.float :points
      t.integer :status

      t.timestamps
    end

    add_index :division_players, :account_id
    add_index :division_players, :division_id
  end
end
