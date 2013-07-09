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

  # Test that the following conditions on the registrations for the given handles are true:
  #     * Both registrations exist
  #     * Both registrations exist in the same event period for the given date
  #     * Both registrations belong to the same registration group
  def self.check_registration_parity(args)
    ignore_case = args[:ignore_case] && true
    date = args[:date]
    handles = args[:handles]
    raise ArgumentError.new('Invalid number of handles') unless handles.size == 2

    query = "
      SELECT COUNT(*)
        FROM registrations
        INNER JOIN accounts ON accounts.id = registrations.account_id
        INNER JOIN registrations AS other_regs ON other_regs.event_period_id = registrations.event_period_id
        INNER JOIN accounts AS other_accounts ON other_accounts.id = other_regs.account_id
        INNER JOIN event_periods ON event_periods.id = registrations.event_period_id
        WHERE
          accounts.handle = '%s'
          AND other_accounts.handle = '%s'
          AND '%s' >= DATE(event_periods.starts_at)
          AND '%s' <= DATE(event_periods.ends_at)
          AND registrations.registration_group_id > 0
          AND registrations.registration_group_id = other_regs.registration_group_id"
    query.gsub!(/(\w+\.handle)[^']+'%s'/, 'LOWER(\1) = LOWER(\'%s\')') if ignore_case
    query = ActiveRecord::Base.send(:sanitize_sql_array, [query, handles[0], handles[1], date, date])
    Registration.count_by_sql(query) > 0
  end

end
