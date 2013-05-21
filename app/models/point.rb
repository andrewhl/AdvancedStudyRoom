# == Schema Information
#
# Table name: points
#
#  id              :integer          not null, primary key
#  count           :float
#  account_id      :integer
#  event_id        :integer
#  match_id        :integer
#  event_desc      :string(255)
#  event_type      :string(255)
#  disabled        :boolean          default(FALSE), not null
#  disabled_reason :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Point < ActiveRecord::Base
  attr_protected

  belongs_to :registration
  belongs_to :account
  belongs_to :event
  belongs_to :match

  scope :league_points, where(:event_type => "League")
  scope :tournament_points, where(:event_type => "Tournament")


end
