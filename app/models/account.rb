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
#  division_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :server_id,
                  :handle,
                  :rank,
                  :league_active,
                  :league_tier,
                  :user_id,
                  :event_id

  has_many :division_players
  has_many :points
  has_many :registrations, :dependent => :destroy
  has_many :events, :through => :registrations
  belongs_to :server
  belongs_to :user
  belongs_to :league
  belongs_to :division

  validates_presence_of :handle, :rank
  validates_uniqueness_of :handle

  def event_points *event_id
    if event_id
      self.points.where(:event_id => event_id)
    else
      self.points.event_points
    end
  end

  def league_points
    self.points.league_points
  end

  def tournament_points
    self.points.tournament_points
  end

end
