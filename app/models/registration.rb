# == Schema Information
#
# Table name: registrations
#
#  id                :integer          not null, primary key
#  account_id        :integer
#  event_id          :integer
#  division_id       :integer
#  active            :boolean          default(TRUE), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  points_this_month :float            default(0.0), not null
#

class Registration < ActiveRecord::Base

  belongs_to :account
  belongs_to :division
  belongs_to :event

  has_one :server, through: :account

  has_many :points

  scope :active, where(active: true)

  attr_accessible :account_id,
                  :division_id,
                  :event_id,
                  :registration


  def get_rank
    return "?" unless last_match = own_matches.last
    last_match.comments.select { |c| c.handle == handle }.first.try(:rank) || "?"
  end

  def handle
    account.try(:handle)
  end

  def own_matches
    matches = Match.where("black_player_id = ? or white_player_id = ?", id, id)
    matches.order("completed_at")
  end

  def current_matches
    matches = own_matches
    matches.select { |m| m.created_at.month == Time.now.month }
    matches.order("completed_at")
  end

  def valid_matches
    current_matches.where("valid_match = ?", true)
  end

  def tagged_matches
    current_matches.where("tagged = ?", true)
  end

  def valid_and_tagged_matches
    valid_matches.where("tagged = ?", true)
  end

  def total_points
    self.points.map { |point| point.count }.inject(:+)
  end

end
