# == Schema Information
#
# Table name: registration_groups
#
#  id                         :integer          not null, primary key
#  event_period_id            :integer
#  parent_id                  :integer
#  registration_group_type_id :integer
#  name                       :string(100)
#  min_registrations          :integer
#  max_registrations          :integer
#  position                   :integer          default(1), not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class RegistrationGroup < ActiveRecord::Base

  belongs_to :event_period
  belongs_to :parent, primary_key: :parent_id, class_name: 'RegistrationGroup'
  belongs_to :registration_group_type

  has_one :event, through: :event_period
  has_one :point_ruleset, as: :point_rulesetable
  has_one :ruleset, as: :rulesetable

  has_many :matches
  has_many :registrations

  # OPTIMIZE: No model should have accept_nested_attributes_for, we should use a form model
  accepts_nested_attributes_for :ruleset, allow_destroy: true
  # OPTIMIZE: No model should have attr_accessible, we should use strong parameters
  attr_accessible :event_id, :integer, :max_registrations, :min_registrations, :name, :parent_id, :registration_group_type_id

  validate :players_within_range

  scope :alphabetical, order('"registration_groups"."name" ASC')
  scope :ranked, order('"registration_groups"."index" ASC')

  def display_name
    name.presence || "#{parent.try(:name)} #{position.to_s}"
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
    rule_merger = ASR::RuleMerger.new(event.ruleset, parent.ruleset, ruleset)
    rule_merger.rules
  end

  def point_rules
    rule_merger = ASR::RuleMerger.new(event.point_ruleset, parent.point_ruleset, point_ruleset)
    rule_merger.rules
  end

  private

    def players_within_range
      if min_registrations.to_i > 0 && min_registrations.to_i >= max_registrations.to_i
        errors.add(:min_registrations, "can't be greater than or equal to the maximum number of players")
      end
      if max_registrations.to_i > 0 && max_registrations.to_i <= min_registrations.to_i
        errors.add(:max_registrations, "can't be less than or equal to the minimum number of players")
      end
    end

end
