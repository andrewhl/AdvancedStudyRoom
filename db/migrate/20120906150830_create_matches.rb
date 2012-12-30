class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :datetime_completed
      t.string   :game_type
      t.float    :komi
      t.string   :winner
      t.string   :win_info
      t.float    :main_time_control
      t.string   :overtime_type
      t.integer  :ot_stones_periods
      t.float    :ot_time_control
      t.string   :url
      t.integer  :black_player_id
      t.integer  :white_player_id
      t.string   :black_player_name
      t.string   :white_player_name
      t.integer  :handicap
      t.string   :game_digest
      t.integer  :division_id
      t.string   :winner_name
      t.integer  :winner_id
      t.integer  :board_size
      t.boolean  :valid_game
      t.boolean  :tagged
      t.string   :url

      t.timestamps
    end

    add_index :matches, :black_player_name
    add_index :matches, :white_player_name
    add_index :matches, :black_player_id
    add_index :matches, :white_player_id
    add_index :matches, :division_id
    add_index :matches, :winner_id
  end
end
