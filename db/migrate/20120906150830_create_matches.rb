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

      t.timestamps
    end

    add_index :matches, :black_player_id
    add_index :matches, :white_player_id
  end
end
