# == Schema Information
#
# Table name: divisions
#
#  id               :integer          not null, primary key
#  tier_id          :integer
#  month            :datetime
#  division_index   :integer
#  minimum_players  :integer
#  maximum_players  :integer
#  current_players  :integer
#  safe_position    :integer
#  promoted_players :integer
#  demoted_players  :integer
#

require 'test_helper'

class DivisionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
