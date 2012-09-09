# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  datetime_completed :datetime
#  game_type          :string(255)
#  komi               :float
#  result             :string(255)
#  main_time_control  :float
#  overtime_type      :string(255)
#  ot_stones_periods  :integer
#  ot_time_control    :float
#  url                :string(255)
#  black_player_id    :integer
#  white_player_id    :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
