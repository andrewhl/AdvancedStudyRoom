class AddGameDigestToRegistrationMatches < ActiveRecord::Migration
  def change
    add_column :registration_matches, :game_digest, :string
  end
end
