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
#  handicap_default      :float
#  ruleset_default       :integer
#  games_per_player      :integer
#  games_per_opponent    :integer
#  canonical             :boolean
#  type                  :string(255)
#  division_id           :integer
#  tier_id               :integer
#  event_id              :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class TierRuleset < EventRuleset

  belongs_to :tier

  def parent
    EventRuleset.find(parent_id)
  end

end
