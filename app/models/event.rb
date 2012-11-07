# == Schema Information
#
# Table name: events
#
#  id                    :integer          not null, primary key
#  event_type_id         :integer
#  name                  :string(255)
#  start_time            :datetime
#  end_time              :datetime
#  event_type_name       :string(255)
#  allowed_rengo         :boolean
#  allowed_teaching      :boolean
#  allowed_review        :boolean
#  allowed_free          :boolean
#  allowed_rated         :boolean
#  allowed_simul         :boolean
#  allowed_demonstration :boolean
#  tag_text              :string(255)
#  main_time_min         :float
#  main_time_max         :float
#  overtime_required     :boolean
#  jovertime_allowed     :boolean
#  covertime_allowed     :boolean
#  jot_min_periods       :integer
#  jot_max_periods       :integer
#  jot_min_period_length :float
#  jot_max_period_length :float
#  cot_min_stones        :integer
#  cot_max_stones        :integer
#  cot_max_time          :float
#  cot_min_time          :float
#  handicap_default      :float
#  ruleset_default       :integer
#  games_per_player      :integer
#  games_per_opponent    :integer
#  league_id             :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#


class Event < ActiveRecord::Base
  attr_accessible :end_time, :name, :start_time, :type, :tag_text, :main_time_max, :main_time_min, :overtime_required, :jovertime_allowed, :covertime_allowed, :jot_min_periods, :jot_max_periods, :jot_min_period_length, :jot_max_period_length, :cot_min_stones, :cot_max_stones, :handicap_default, :ruleset_default, :games_per_player, :games_per_opponent, :event_type_id

  belongs_to :event_type
  belongs_to :league

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
