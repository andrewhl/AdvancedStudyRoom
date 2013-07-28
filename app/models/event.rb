# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  event_type         :string(255)
#  server_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#  prizes_description :text
#  starts_at          :datetime
#  ends_at            :datetime
#  opens_at           :datetime
#  closes_at          :datetime
#


class Event < ActiveRecord::Base

  belongs_to :server

  has_one :ruleset, as: :rulesetable, dependent: :destroy
  has_one :point_ruleset, as: :pointable, dependent: :destroy

  has_many :accounts, through: :registrations
  has_many :divisions, through: :tiers, order: '"tiers"."index" ASC, "divisions"."index" ASC'
  has_many :points, dependent: :destroy
  has_many :registrations, include: :account, dependent: :destroy, order: 'LOWER("accounts"."handle") ASC'
  has_many :matches, through: :divisions
  has_many :tags, class_name: 'EventTag', dependent: :destroy, order: 'phrase ASC'
  has_many :tiers, dependent: :destroy, order: '"tiers"."index" ASC'

  scope :live, where('starts_at IS NOT NULL AND DATE(starts_at) <= CURRENT_DATE AND
                      ends_at IS NOT NULL AND CURRENT_DATE <= DATE(ends_at)').
               order('ends_at DESC')

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

  def open?
    # TODO: Use the opens_at and closes_at dates once these are in use
    return true if opens_at.nil? || closes_at.nil?
    opens_at.to_date <= Time.zone.today && Time.zone.today <= closes_at.to_date
  end

  def live?
    return true if starts_at.nil? || ends_at.nil?
    starts_at.to_date <= Time.zone.today && Time.zone.today <= ends_at.to_date
  end

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
