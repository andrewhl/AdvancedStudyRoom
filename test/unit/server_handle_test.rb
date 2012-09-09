# == Schema Information
#
# Table name: server_handles
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  server_id     :integer
#  league_id     :integer
#  handle        :string(255)
#  league_tier   :integer
#  league_active :integer
#  rank          :integer
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class ServerandleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
