# == Schema Information
#
# Table name: server_handles
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  server_id     :integer
#  league_id     :integer
#  handle        :string(255)
#  league_tier   :integer
#  league_active :integer
#  rank          :integer
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ServerHandle < ActiveRecord::Base
  attr_accessible :handle, :rank, :league_active, :league_tier, :user_id

  has_one :division_player
  belongs_to :server
  belongs_to :user
  belongs_to :league
end
