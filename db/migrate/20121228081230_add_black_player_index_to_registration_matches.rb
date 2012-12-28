class AddBlackPlayerIndexToRegistrationMatches < ActiveRecord::Migration
  def change
    add_index :registration_matches, :black_player_id
    add_index :registration_matches, :white_player_id
  end
end
