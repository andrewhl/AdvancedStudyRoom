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

require 'test_helper'

class TierTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
