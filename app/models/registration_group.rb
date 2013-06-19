# == Schema Information
#
# Table name: registration_groups
#
#  id                         :integer          not null, primary key
#  event_id                   :integer
#  parent_id                  :integer
#  registration_group_type_id :integer
#  name                       :string(100)
#  min_registrations          :integer
#  max_registrations          :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  position                   :integer          default(1), not null
#

class RegistrationGroup < ActiveRecord::Base
  attr_accessible :event_id, :integer, :max_registrations, :min_registrations, :name, :parent_id, :registration_group_type_id

  has_one :registration_group_type
  has_one :event
  has_one :parent, foreign_key: :parent_id, class_name: 'RegistrationGroup'

  accepts_nested_attributes_for :ruleset, allow_destroy: true

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
