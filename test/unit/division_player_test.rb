# == Schema Information
#
# Table name: division_players
#
#  id            :integer          not null, primary key
#  division_id   :integer
#  kgs_handle_id :integer
#  points        :float
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class DivisionPlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
