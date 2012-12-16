# == Schema Information
#
# Table name: points
#
#  id              :integer          not null, primary key
#  count           :integer
#  account_id      :integer
#  event_id        :integer
#  event_desc      :string(255)
#  event_type      :string(255)
#  game_hash       :string(255)
#  registration_id :integer
#  enabled         :boolean
#  match_id        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Point < ActiveRecord::Base
  attr_accessible :account_id,
                  :count,
                  :event_desc,
                  :event_type,
                  :event_id,
                  :registration_id,
                  :match_id

  belongs_to :registration
  belongs_to :account
  belongs_to :event
  belongs_to :match

  scope :league_points, where(:event_type => "League")
  scope :tournament_points, where(:event_type => "Tournament")


end
