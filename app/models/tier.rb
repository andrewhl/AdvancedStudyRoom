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
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Tier < ActiveRecord::Base
  attr_accessible :name, :demotions, :divisions, :event_id, :max_games_per_opponent, :max_games_per_player, :points_per_loss, :points_per_win, :promotions, :tier_hierarchy_position, :tier_type_id

  has_many :divisions
  belongs_to :league
  belongs_to :tier_type
  belongs_to :event
end
