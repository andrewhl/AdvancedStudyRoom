# == Schema Information
#
# Table name: registrations
#
#  id                :integer          not null, primary key
#  account_id        :integer
#  event_id          :integer
#  division_id       :integer
#  handle            :string(255)
#  active            :boolean
#  display_name      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  points_this_month :float
#

require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
