class Match < ActiveRecord::Base
  attr_accessible :datetime_completed, :game_type, :komi, :main_time_control, :ot_stones_periods, :ot_time_control, :overtime_type, :result, :url

  belongs_to :black_player, :class_name => 'DivisionPlayer'
  belongs_to :white_player, :class_name => 'DivisionPlayer'

end
