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

['net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils'].each { |x| require x }

class Ruleset < ActiveRecord::Base
  attr_accessible :allowed_demonstration,
                  :allowed_free,
                  :allowed_rated,
                  :allowed_rengo,
                  :allowed_review,
                  :allowed_simul,
                  :allowed_teaching,
                  :cot_max_stones,
                  :cot_min_stones,
                  :cot_max_time,
                  :cot_min_time,
                  :covertime_allowed,
                  :games_per_opponent,
                  :games_per_player,
                  :handicap_default,
                  :jot_max_period_length,
                  :jot_max_periods,
                  :jot_min_period_length,
                  :jot_min_periods,
                  :jovertime_allowed,
                  :main_time_max,
                  :main_time_min,
                  :name,
                  :overtime_required,
                  :ruleset_default,
                  :tag_text,
                  :division_id,
                  :tier_id,
                  :event_id,
                  :type,
                  :canonical

  has_many :leagues
  has_many :events

  scope :canon, where(:canonical => true)
  scope :event_rulesets, where(:type => "EventRuleset")
  scope :tier_rulesets, where(:type => "TierRuleset")
  scope :division_rulesets, where(:type => "DivisionRuleset")

  def destroy
    events = self.events
    events.each do |event|
      event.ruleset_id = nil
      event.save
    end
    super
  end

  def validate_game game

    # game is a Match object

    valid_game = false
    if false
      return true
    else
      return false
    end

    # binding.pry



  end

end
