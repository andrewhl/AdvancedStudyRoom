# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  html       :text
#  user_id    :integer
#  date       :datetime
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  permalink  :string(255)
#

require 'spec_helper'

describe Post do
  pending "add some examples to (or delete) #{__FILE__}"
end
