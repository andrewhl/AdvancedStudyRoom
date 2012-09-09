# == Schema Information
#
# Table name: achievements
#
#  id                :integer          not null, primary key
#  achievement_name  :string(255)
#  earned_image_url  :string(255)
#  pending_image_url :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class AchievementTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
