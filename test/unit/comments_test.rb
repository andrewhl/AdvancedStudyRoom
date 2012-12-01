# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  match_id   :integer
#  node       :integer
#  comment    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CommentsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
