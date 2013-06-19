# == Schema Information
#
# Table name: points
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  count           :float
#  description     :text
#  disabled_reason :string(255)
#  disabled        :boolean          default(FALSE), not null
#  disabled_at     :datetime
#  awarded_at      :datetime
#  pointable_id    :integer
#  pointable_type  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Point < ActiveRecord::Base
  attr_protected

  belongs_to :account
  belongs_to :pointable, polymorphic: true
end
