# == Schema Information
#
# Table name: rulesets
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
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
#  cot_max_time          :float
#  cot_min_time          :float
#  ruleset_default       :integer
#  games_per_player      :integer
#  games_per_opponent    :integer
#  canonical             :boolean
#  type                  :string(255)
#  division_id           :integer
#  tier_id               :integer
#  event_id              :integer
#  parent_id             :integer
#  ruleset_id            :integer
#  max_komi              :float
#  min_komi              :float
#  max_handi             :integer
#  min_handi             :integer
#  handicap_required     :boolean
#  max_board_size        :integer
#  min_board_size        :integer
#  node_limit            :integer
#  points_per_win        :float
#  points_per_loss       :float
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class EventRuleset < Ruleset
  belongs_to :event
  belongs_to :ruleset

  def parent
    Ruleset.find(parent_id)
  end

end
