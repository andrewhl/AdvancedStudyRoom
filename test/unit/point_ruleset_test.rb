# == Schema Information
#
# Table name: point_rulesets
#
#  id              :integer          not null, primary key
#  parent_id       :integer
#  parent_type     :string(255)
#  points_per_win  :float
#  points_per_loss :float
#  point_decay     :float
#  type            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  points_for_game :float
#

require 'test_helper'

class PointRulesetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
