# == Schema Information
#
# Table name: awards
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  achievement_id :integer
#  date_awarded   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class AwardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
