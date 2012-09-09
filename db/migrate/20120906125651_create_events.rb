class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer  :event_type_id
      t.string   :name
      t.datetime :start_time
      t.datetime :end_time
      t.string   :event_type_name
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
      t.float    :handicap_default
      t.integer  :ruleset_default
      t.integer  :games_per_player
      t.integer  :games_per_opponent
      t.integer  :league_id

      t.timestamps
    end

    add_index :events, :event_type_id
    add_index :events, :league_id
  end
end
