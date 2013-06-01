# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  date       :datetime
#  user_id    :integer
#  html       :text
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sort_order :integer
#  permalink  :string(255)
#

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end
