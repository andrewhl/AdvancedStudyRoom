class CreateRulesets < ActiveRecord::Migration
  def change
    create_table :rulesets do |t|
      t.string   :name
      t.float    :main_time_min
      t.float    :main_time_max
      t.boolean  :overtime_required
      t.boolean  :jovertime_allowed
      t.boolean  :covertime_allowed
      t.integer  :jot_min_periods
      t.integer  :jot_max_periods
      t.float    :jot_min_period_length
      t.float    :jot_max_period_length
      t.integer  :cot_min_stones
      t.integer  :cot_max_stones
      t.float    :cot_max_time
      t.float    :cot_min_time
      t.integer  :ruleset_default
      t.integer  :games_per_player
      t.integer  :games_per_opponent
      t.boolean  :canonical
      t.string   :type
      t.integer  :division_id
      t.integer  :tier_id
      t.integer  :event_id
      t.integer  :parent_id
      t.integer  :ruleset_id
      t.float    :max_komi
      t.float    :min_komi
      t.integer  :max_handi
      t.integer  :min_handi
      t.boolean  :handicap_required
      t.integer  :max_board_size
      t.integer  :min_board_size
      t.integer  :node_limit
      t.float    :points_per_win
      t.float    :points_per_loss

      t.timestamps
    end

    add_index :rulesets, :division_id
    add_index :rulesets, :tier_id
    add_index :rulesets, :event_id
    add_index :rulesets, :parent_id
    add_index :rulesets, :ruleset_id

  end
end
