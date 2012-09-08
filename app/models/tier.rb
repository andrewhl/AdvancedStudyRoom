class Tier < ActiveRecord::Base
  attr_accessible :demotions, :divisions, :event_id, :max_games_per_opponent, :max_games_per_player, :points_per_loss, :points_per_win, :promotions, :tier_hierarchy_position, :tier_type_id

  has_many :divisions
  belongs_to :tier_type
end
