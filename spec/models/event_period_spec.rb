# == Schema Information
#
# Table name: event_periods
#
#  id         :integer          not null, primary key
#  event_id   :integer
#  starts_at  :datetime
#  ends_at    :datetime
#  opens_at   :datetime
#  closes_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe EventPeriod do
  pending "add some examples to (or delete) #{__FILE__}"
end
