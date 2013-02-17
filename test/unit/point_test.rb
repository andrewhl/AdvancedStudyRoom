# == Schema Information
#
# Table name: points
#
#  id              :integer          not null, primary key
#  count           :float
#  account_id      :integer
#  event_id        :integer
#  event_desc      :string(255)
#  event_type      :string(255)
#  registration_id :integer
#  enabled         :boolean
#  match_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class PointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
