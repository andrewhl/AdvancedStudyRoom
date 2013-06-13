# == Schema Information
#
# Table name: points
#
#  id              :integer          not null, primary key
#  count           :float
#  account_id      :integer
#  registration_id :integer
#  match_id        :integer
#  event_desc      :string(255)
#  disabled_reason :string(255)
#  disabled        :boolean          default(FALSE), not null
#  awarded_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Point < ActiveRecord::Base
  attr_protected

  belongs_to :registration
  belongs_to :account
  belongs_to :match

end
