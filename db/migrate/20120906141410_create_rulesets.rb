class CreateRulesets < ActiveRecord::Migration
  def change
    create_table :rulesets do |t|
      t.string   :name
      t.boolean  :allowed_rengo
      t.boolean  :allowed_teaching
      t.boolean  :allowed_review
      t.boolean  :allowed_free
      t.boolean  :allowed_rated
      t.boolean  :allowed_simul
      t.boolean  :allowed_demonstration
      t.string   :tag_text
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
      t.float    :handicap_default
      t.integer  :ruleset_default
      t.integer  :games_per_player
      t.integer  :games_per_opponent
      t.boolean  :canonical
      t.string   :type
      t.integer  :division_id
      t.integer  :tier_id
      t.integer  :event_id

      t.timestamps
    end

    add_index :rulesets, :division_id
    add_index :rulesets, :tier_id
    add_index :rulesets, :event_id

  end
end
