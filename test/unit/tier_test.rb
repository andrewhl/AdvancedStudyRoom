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

require 'test_helper'

class TierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
