# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string(100)
#  description        :text
#  prizes_description :text
#  event_type_id      :integer
#  server_id          :integer
#  starts_at          :datetime
#  ends_at            :datetime
#  opens_at           :datetime
#  closes_at          :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#


class Event < ActiveRecord::Base

  belongs_to :server

  has_one :ruleset, as: :rulesetable, dependent: :destroy
  has_one :point_ruleset, as: :pointable, dependent: :destroy
  has_one :event_type

  has_many :accounts, through: :registrations
  # TODO: Remove the divisions
  has_many :divisions, through: :tiers, order: '"tiers"."index" ASC, "divisions"."index" ASC'
  has_many :points, dependent: :destroy
  has_many :registrations, include: :account, dependent: :destroy, order: 'LOWER("accounts"."handle") ASC'
  has_many :matches, through: :divisions
  has_many :registration_groups
  has_many :tags, class_name: 'EventTag', dependent: :destroy, order: 'phrase ASC'
  # TODO: Remove the tiers
  has_many :tiers, dependent: :destroy, order: '"tiers"."index" ASC'

  attr_accessible :ruleset_id,
                  :name,
                  :start_time
                  :end_time
                  :event_type
                  :server
                  :locked
                  :ruleset_attributes

  accepts_nested_attributes_for :tiers, allow_destroy: true
  accepts_nested_attributes_for :ruleset, allow_destroy: true
  accepts_nested_attributes_for :registrations, allow_destroy: true
  accepts_nested_attributes_for :tags

  scope :leagues, joins(:event_type).where("event_types.name = 'league'")

  def ruleset_id=(id)
    self.ruleset = Ruleset.find(id)
  end

  def ruleset_id
    self.ruleset.try :id
  end

  def ruleset?
    ruleset.present?
  end

  def player_count
    registrations.count
  end

end
