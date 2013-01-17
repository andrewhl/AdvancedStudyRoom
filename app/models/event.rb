# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  ruleset_id      :integer
#  name            :string(255)
#  start_time      :datetime
#  end_time        :datetime
#  ruleset_name    :string(255)
#  event_type      :string(255)
#  ruleset_default :integer
#  league_id       :integer
#  server_id       :integer
#  locked          :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


class Event < ActiveRecord::Base
  attr_protected

  belongs_to :ruleset
  belongs_to :server
  has_one :event_ruleset, :dependent => :destroy
  has_many :registrations
  has_many :accounts, :through => :registrations
  has_many :tiers, dependent: :destroy
  has_many :tags
  has_many :divisions
  has_many :points

  accepts_nested_attributes_for :tiers, allow_destroy: true
  accepts_nested_attributes_for :accounts
  accepts_nested_attributes_for :event_ruleset, allow_destroy: true
  accepts_nested_attributes_for :registrations, allow_destroy: true
  accepts_nested_attributes_for :tags

  scope :leagues, where(:event_type => "League")
  scope :tournaments, where(:event_type => "Tournament")

  def ruleset?
    !ruleset.nil? or !event_ruleset.nil?
  end

  def player_count
    tiers.map { |tier| tier.player_count.nil? ? 0 : tier.player_count }.inject(&:+)
  end

  def matches
    matches = []
    divisions.each do |division|
      matches << division.matches
    end
    matches.flatten
  end

  def validate_games

    matches.each do |match|
      if match.is_valid?
        match.update_attribute(:valid_game, true)
      else
        match.update_attribute(:valid_game, false)
      end
    end
  end

  def tag_games force=false

    matches.each do |match|
      unless force
        next if match.tagged == true or match.tagged == false
      end

      if match.has_valid_tag?
        match.update_attribute(:tagged, true)
      else
        match.update_attribute(:tagged, false)
      end
    end
  end

  def validate_game game

    # binding.pry
    # game is a Match object

    # Check komi
    unless game.komi == self.handicap_default
      return false, "Invalid komi"
    end

    # Check main time setting
    unless (game.main_time_control <= self.main_time_max) or (game.main_time_control >= self.main_time_min)
      return false, "Invalid main time setting"
    end

    # Check Japanese overtime settings
    if game.overtime_type == "byo_yomi"
      unless (game.ot_time_control >= self.jot_min_periods) or (game.ot_time_control <= self.jot_max_periods)
        return false, "Invalid Japanese main time setting"
      end

      unless (game.ot_stones_periods >= self.jot_min_period_length) or (game.ot_stones_periods <= self.jot_max_period_length)
        return false, "Invalid Japanese overtime setting"
      end
    end

    # Check Canadian overtime settings
    if game.overtime_type == "Canadian"
      unless (game.ot_time_control >= self.cot_min_time) or (game.ot_time_control <= self.cot_max_time)
        return false, "Invalid Canadian main time setting"
      end

      unless (game.ot_stones_periods >= self.cot_min_stones) or (game.ot_stones_periods <= self.cot_max_stones)
        return false, "Invalid Canadian overtime setting"
      end
    end




    return true
    # binding.pry



  end
end
