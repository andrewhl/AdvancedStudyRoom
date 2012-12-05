# == Schema Information
#
# Table name: tiers
#
#  id                      :integer          not null, primary key
#  tier_type_id            :integer
#  promotions              :integer
#  demotions               :integer
#  tier_hierarchy_position :integer
#  divisions               :integer
#  max_games_per_player    :integer
#  max_games_per_opponent  :integer
#  points_per_win          :float
#  points_per_loss         :float
#  event_id                :integer
#  league_id               :integer
#  name                    :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Tier < ActiveRecord::Base
  attr_accessible :name,
                  :demotions,
                  :divisions,
                  :event_id,
                  :max_games_per_opponent,
                  :max_games_per_player,
                  :points_per_loss,
                  :points_per_win,
                  :promotions,
                  :tier_hierarchy_position,
                  :tier_type_id,
                  :tier_ruleset_attributes,
                  :tier_ruleset

  scope :ranked, order("tier_hierarchy_position ASC")

  validates_presence_of :name, :on => :create, :message => "can't be blank"

  has_many :divisions, :dependent => :destroy
  has_one :tier_ruleset, :dependent => :destroy
  belongs_to :league
  belongs_to :tier_type
  belongs_to :event

  accepts_nested_attributes_for :tier_ruleset, allow_destroy: true

  def ruleset
    tier_ruleset
  end

  def ruleset?
    !tier_ruleset.nil?
  end

  def player_count
    divisions.map { |div| div.registrations.nil? ? 0 : div.registrations.count }.inject(&:+)
  end
end

