class AddPlayerNameIndexesToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :black_player_name
    add_index :matches, :white_player_name
  end
end
