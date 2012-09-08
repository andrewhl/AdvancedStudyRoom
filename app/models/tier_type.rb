class TierType < ActiveRecord::Base
  attr_accessible :default_demotions, :default_divisions, :default_promotions, :max_games_per_opponent, :max_games_per_player, :name, :points_per_loss, :points_per_win, :tier_hierarchy_position

  has_many :tiers
  has_many :events

end
