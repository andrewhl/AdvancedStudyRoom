class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
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

      t.timestamps
    end

  end
end
