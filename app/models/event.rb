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
  belongs_to :event_type

  has_one :ruleset, as: :rulesetable, dependent: :destroy, autosave: true
  has_one :point_ruleset, as: :point_rulesetable, dependent: :destroy, autosave: true
  has_one :event_type

  has_many :accounts, through: :registrations
  has_many :registration_groups, order: '"registration_groups"."index" ASC'
  has_many :registrations, include: :account, dependent: :destroy, order: 'LOWER("accounts"."handle") ASC'
  has_many :matches, through: :registration_groups
  has_many :registration_groups
  has_many :tags, class_name: 'EventTag', dependent: :destroy, order: 'phrase ASC'

  attr_accessible :ruleset_id,
                  :name,
                  :start_time
                  :end_time
                  :event_type
                  :server
                  :locked
                  :ruleset_attributes

  accepts_nested_attributes_for :registration_groups, allow_destroy: true
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

  def self.check_registration_parity(args)
    ignore_case = args[:ignore_case] || true
    date = args[:date]
    query = "accounts.handle = ?"
    if ignore_case
      query = "LOWER(accounts.handle) = ?"
    end
    query += " AND DATE(event_periods.starts_at) <= ? AND DATE(event_periods.ends_at) >= ?"

    handles = args[:handles]

    registrations = handles.collect do |handle|
      Registration.joins(:account, :event_period).where(query, handle, date, date)
    end

    test_id = registrations[0].event_period_id
    registrations.any? { |reg| reg.event_period_id != test_id } ? false : true
  end

end
