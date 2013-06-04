# == Schema Information
#
# Table name: tiers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  index      :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tier < ActiveRecord::Base

  belongs_to :event
  belongs_to :league
  belongs_to :tier_type

  has_one :ruleset, as: :rulesetable, dependent: :destroy
  has_one :point_ruleset, as: :pointable, dependent: :destroy

  has_many :divisions, dependent: :destroy
  has_many :registrations, through: :divisions


  attr_accessible :name,
                  :demotions,
                  :divisions,
                  :event_id,
                  :max_matches_per_player,
                  :points_per_loss,
                  :points_per_win,
                  :promotions,
                  :index,
                  :ruleset_attributes

  accepts_nested_attributes_for :ruleset, allow_destroy: true

  validates_presence_of :name, on: :create

  scope :ranked, order('"tiers"."index" ASC')

  def display_name
    name.presence || "#{event.try(:name)} Tier #{index.to_s}"
  end

end

