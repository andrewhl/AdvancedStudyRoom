# == Schema Information
#
# Table name: rulesets
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  allowed_rengo         :boolean
#  allowed_teaching      :boolean
#  allowed_review        :boolean
#  allowed_free          :boolean
#  allowed_rated         :boolean
#  allowed_simul         :boolean
#  allowed_demonstration :boolean
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
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class TierRuleset < EventRuleset

  belongs_to :tier

  def parent
    EventRuleset.find(parent_id)
  end

  def event
    event = event || parent.event
  end

end
