# == Schema Information
#
# Table name: registrations
#
#  id         :integer          not null, primary key
#  account_id :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Registration < ActiveRecord::Base
  attr_accessible :account_id, :event_id, :registration

  belongs_to :event
  belongs_to :account
end
