# == Schema Information
#
# Table name: match_tags
#
#  id         :integer          not null, primary key
#  match_id   :integer
#  comment_id :integer
#  node       :integer
#  phrase     :string(100)
#  handle     :string(100)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe MatchTag do
  pending "add some examples to (or delete) #{__FILE__}"
end
