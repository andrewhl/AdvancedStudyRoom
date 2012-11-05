# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  event_type_id         :integer
#  name                  :string(255)
#  start_time            :datetime
#  end_time              :datetime
#  event_type_name       :string(255)
#  allowed_rengo         :boolean
#  allowed_teaching      :boolean
#  allowed_review        :boolean
#  allowed_free          :boolean
#  allowed_rated         :boolean
#  allowed_simul         :boolean
#  allowed_demonstration :boolean
#  tag_text              :string(255)
#  main_time_min         :float
#  main_time_max         :float
#  overtime_required     :boolean
#  jovertime_allowed     :boolean
#  covertime_allowed     :boolean
#  jot_min_periods       :integer
#  jot_max_periods       :integer
#  jot_min_period_length :float
#  jot_max_period_length :float
#  cot_min_stones        :integer
#  cot_max_stones        :integer
#  handicap_default      :float
#  ruleset_default       :integer
#  games_per_player      :integer
#  games_per_opponent    :integer
#  league_id             :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#


class Event < ActiveRecord::Base
  attr_accessible :end_time, :name, :start_time, :type, :tag_text, :main_time_max, :main_time_min, :overtime_required, :jovertime_allowed, :covertime_allowed, :jot_min_periods, :jot_max_periods, :jot_min_period_length, :jot_max_period_length, :cot_min_stones, :cot_max_stones, :handicap_default, :ruleset_default, :games_per_player, :games_per_opponent, :event_type_id

  belongs_to :event_type
  belongs_to :league
end
