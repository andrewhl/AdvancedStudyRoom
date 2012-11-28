# == Schema Information
#
# Table name: accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  server_id     :integer
#  event_id      :integer
#  handle        :string(255)
#  league_tier   :integer
#  league_active :integer
#  rank          :integer
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :server_id, :handle, :rank, :league_active, :league_tier, :user_id, :event_id

  has_many :division_players
  belongs_to :server
  belongs_to :user
  belongs_to :league
  belongs_to :event
end
