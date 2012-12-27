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
                  :parent_id,
                  :type,
                  :canonical,
                  :min_handi,
                  :max_handi,
                  :handicap_required

  has_many :leagues
  has_many :events
  has_many :event_rulesets

  scope :canon, where(:canonical => true)
  scope :event_rulesets, where(:type => "EventRuleset")
  scope :tier_rulesets, where(:type => "TierRuleset")
  scope :division_rulesets, where(:type => "DivisionRuleset")

  before_destroy :ensure_no_children
  before_destroy :clear_event_id

  def ensure_no_children
    if not event_rulesets.empty?
      # raise ActiveRecord::Rollback, "Ruleset has children, and cannot be deleted."
      errors.add(:base, "Ruleset has child rulesets, and cannot be deleted.")
      return false
    end
  end

  # if you destroy a canonical ruleset,
  # the event it belongs to needs to have the foreign key cleared

  def clear_event_id
    events = self.events
    events.each do |event|
      event.ruleset_id = nil
      event.save
    end
  end

  def is_top_level?
    type.nil? ? true : false
  end

  # add validation that prevents ruleset from being saved if
  # both jovertime and covertimer and false
  # and overtime stones/period settings or control settings are enabled



end
