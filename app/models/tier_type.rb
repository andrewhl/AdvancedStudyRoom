# == Schema Information
#
# Table name: tier_types
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  default_promotions      :integer
#  default_demotions       :integer
#  tier_hierarchy_position :integer
#  default_divisions       :integer
#  max_games_per_player    :integer
#  max_games_per_opponent  :integer
#  points_per_win          :float
#  points_per_loss         :float
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class TierType < ActiveRecord::Base
  attr_accessible :default_demotions, :default_divisions, :default_promotions, :max_games_per_opponent, :max_games_per_player, :name, :points_per_loss, :points_per_win, :tier_hierarchy_position

  has_many :tiers
  has_many :events

end
