# == Schema Information
#
# Table name: registrations
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  event_id    :integer
#  division_id :integer
#  handle      :string(255)
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Registration < ActiveRecord::Base
  attr_accessible :account_id,
                  :event_id, :registration, :division_id, :handle

  belongs_to :event
  belongs_to :account
  belongs_to :division
  has_many :points
  # has_many :registration_matches

  # def registration_matches
  #   matches = RegistrationMatch.where("black_player_id = ? or white_player_id = ?", id, id)
  # end

  def own_matches
    matches = Match.where("black_player_id = ? or white_player_id = ?", id, id)
    matches
  end

  def current_matches
    matches = own_matches
    matches.select { |m| m.created_at.month == Time.now.month }
    matches
  end

  def matches_with registration, *current
    if registration.is_a? Fixnum
      matches = own_matches.where("black_player_id = ? or white_player_id = ?", registration, registration) unless current[0] != true
      matches = current_matches.where("black_player_id = ? or white_player_id = ?", registration, registration) if current[0] == true
    elsif registration.is_a? String
      matches = own_matches.where("black_player_name = ? or white_player_name = ?", registration, registration) unless current[0] != true
      matches = current_matches.where("black_player_name = ? or white_player_name = ?", registration, registration) if current[0] == true
    else
      raise TypeError, "Must be a String or a Fixnum."
    end
    matches
  end

  def match_results current=true, result=true, *opponent
    # binding.pry
    case result
    when true
      sql_string = "winner_id = ?"
    when false
      sql_string = "winner_id != ?"
    end

    if current and opponent.empty? # will return current won matches
      matches = current_matches.where(sql_string, id)
    elsif current and !opponent.empty? # will return current won matches against X
      matches = matches_with(opponent[0], true)
      matches = matches.where(sql_string, id)
    elsif !current and opponent.empty? # will return all won matches
      matches = own_matches.where(sql_string, id)
    elsif !current and !opponent.empty? # will return all won matches against X
      matches = matches_with(opponent[0], false)
      matches = matches.where(sql_string, id)
    end
    matches
  end

end
