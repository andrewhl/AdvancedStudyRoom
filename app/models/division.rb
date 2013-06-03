# == Schema Information
#
# Table name: divisions
#
#  id              :integer          not null, primary key
#  tier_id         :integer
#  index           :integer
#  minimum_players :integer
#  maximum_players :integer
#  name            :string(255)
#

class Division < ActiveRecord::Base

  belongs_to :tier

  has_one :event, through: :tier
  has_one :ruleset, as: :rulesetable, dependent: :destroy
  has_one :point_ruleset, as: :pointable, dependent: :destroy

  has_many :accounts
  has_many :matches
  has_many :registrations


  attr_accessible :index,
                  :minimum_players,
                  :maximum_players,
                  :safe_position,
                  :promoted_players,
                  :demoted_players,
                  :name
                  :ruleset_attributes

  accepts_nested_attributes_for :ruleset, allow_destroy: true

  validate :players_within_range

  scope :alphabetical, order('"divisions"."name" ASC')
  scope :ranked, order('"divisions"."index" ASC')

  def ranked
    Division.all.collect { |div| div.name }
  end

  def display_name
    name.present? ? name : tier.name + " " + index.to_s
  end

  def ruleset?
    ruleset.present?
  end

  def valid_matches
    matches.where("valid_match = ?", true).order("created_at")
  end

  def valid_and_tagged_matches
    matches.where("valid_match = ? and tagged = ?", true, true).order("created_at")
  end

  def rules
    rule_merger = ASR::RuleMerger.new(event.ruleset, tier.ruleset, ruleset)
    rule_merger.rules
  end

  def point_rules
    rule_merger = ASR::RuleMerger.new(event.point_ruleset, tier.point_ruleset, point_ruleset)
    rule_merger.rules
  end

  private

    def players_within_range
      if minimum_players.to_i > 0 && minimum_players.to_i >= maximum_players.to_i
        errors.add(:minimum_players, "can't be greater than or equal to the maximum number of players")
      end
      if maximum_players.to_i > 0 && maximum_players.to_i <= minimum_players.to_i
        errors.add(:maximum_players, "can't be less than or equal to the minimum number of players")
      end
    end
end
