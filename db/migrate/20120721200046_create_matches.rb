class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string  :url
      t.string  :white_player_name
      t.integer :white_player_rank
      t.string  :black_player_name
      t.integer :black_player_rank
      t.boolean :result_boolean
      t.float   :score
      t.integer :board_size
      t.integer :handi
      t.integer :unixtime
      t.string  :game_type
      t.float   :komi
      t.string  :result
      t.integer :main_time
      t.string  :invalid_reason
      t.string  :ruleset
      t.integer :overtime_periods
      t.integer :overtime_seconds
      t.string  :time_system
      t.string  :black_player_name_2
      t.string  :white_player_name_2
      t.integer :black_player_rank_2
      t.integer :white_player_rank_2
      t.boolean :valid_game
      t.integer :user_id

      t.timestamps
    end
  end
end