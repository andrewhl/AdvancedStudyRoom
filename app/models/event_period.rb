# == Schema Information
#
# Table name: event_periods
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  starts_at  :datetime
#  ends_at    :datetime
#  opens_at   :datetime
#  closes_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventPeriod < ActiveRecord::Base
  belongs_to :event

  has_one :ruleset, as: :rulesetable, dependent: :destroy, autosave: true
  has_one :point_ruleset, as: :point_rulesetable, dependent: :destroy, autosave: true

  has_many :accounts, through: :registrations
  has_many :registration_groups, order: '"registration_groups"."index" ASC'
  has_many :registrations, include: :account, dependent: :destroy, order: 'LOWER("accounts"."handle") ASC'
  has_many :matches, through: :registration_groups
  has_many :registration_groups
end
