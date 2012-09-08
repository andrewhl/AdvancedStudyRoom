class EventType < ActiveRecord::Base
  attr_accessible :allowed_demonstration, :allowed_free, :allowed_rated, :allowed_rengo, :allowed_review, :allowed_simul, :allowed_teaching, :cot_max_stones, :cot_min_stones, :covertime_allowed, :games_per_opponent, :games_per_player, :handicap_default, :jot_max_period_length, :jot_max_periods, :jot_min_period_length, :jot_min_periods, :jovertime_allowed, :main_time_max, :main_time_min, :name, :overtime_required, :ruleset_default, :tag_text
  has_many :events
end
