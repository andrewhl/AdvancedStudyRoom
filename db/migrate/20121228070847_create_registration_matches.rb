class CreateRegistrationMatches < ActiveRecord::Migration
  def change
    create_table :registration_matches do |t|
      t.integer :registration_id
      t.integer :match_id
      t.integer :black_player_id
      t.integer :white_player_id
      t.string :black_player_name
      t.string :white_player_name
      t.integer :winner_id
      t.string :winner_name
      t.integer :division_id

      t.timestamps
    end

    add_index :registration_matches, :match_id
    add_index :registration_matches, :registration_id
    add_index :registration_matches, :division_id
  end
end
