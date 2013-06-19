class CreateMatchData < ActiveRecord::Migration
  def change
    create_table :match_data do |t|
      t.integer  :match_id
      t.integer  :ot_stones_periods
      t.integer  :board_size
      t.integer  :handicap
      t.string   :type, limit: 100
      t.string   :ot_type, limit: 100
      t.string   :win_info, limit: 100
      t.string   :filename
      t.string   :black_player_name, limit: 100
      t.string   :white_player_name, limit: 100
      t.float    :komi
      t.float    :main_time_control
      t.float    :ot_time_control

      t.timestamps
    end

    add_index :match_data, :match_id
  end
end