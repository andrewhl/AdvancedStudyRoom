class AddGameDigestIndexToRegistrationMatches < ActiveRecord::Migration
  def change
    add_index :registration_matches, :game_digest
  end
end
