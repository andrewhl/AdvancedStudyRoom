class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string   :match_type
      t.string   :ot_type
      t.string   :win_info
      t.string   :digest
      t.string   :url
      t.string   :filename
      t.string   :black_player_name
      t.string   :white_player_name
      t.string   :tags
      t.string   :validation_errors
      t.boolean  :valid_match
      t.boolean  :tagged
      t.boolean  :has_points, null: false, default: false
      t.integer  :ot_stones_periods
      t.integer  :black_player_id
      t.integer  :white_player_id
      t.integer  :division_id
      t.integer  :winner_id
      t.integer  :loser_id
      t.integer  :board_size
      t.integer  :handicap
      t.float    :komi
      t.float    :main_time_control
      t.float    :ot_time_control
      t.datetime :completed_at

      t.timestamps
    end

    add_index :matches, :black_player_id
    add_index :matches, :white_player_id
    add_index :matches, :division_id
    add_index :matches, :winner_id
    add_index :matches, :loser_id
  end
end
