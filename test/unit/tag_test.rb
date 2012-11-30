# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  phrase     :string(255)
#  league_id  :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
