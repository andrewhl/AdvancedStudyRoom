# == Schema Information
#
# Table name: matches
#
#  id                 :integer          not null, primary key
#  datetime_completed :datetime
#  game_type          :string(255)
#  komi               :float
#  winner             :string(255)
#  win_info           :string(255)
#  main_time_control  :float
#  overtime_type      :string(255)
#  ot_stones_periods  :integer
#  ot_time_control    :float
#  url                :string(255)
#  black_player_id    :integer
#  white_player_id    :integer
#  black_player       :string(255)
#  white_player       :string(255)
#  handicap           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Match < ActiveRecord::Base
  attr_accessible :datetime_completed, :game_type, :komi, :main_time_control, :ot_stones_periods, :ot_time_control, :overtime_type, :result, :url, :winner, :win_info, :black_player, :white_player, :handicap, :black_player_name, :white_player_name

  belongs_to :black_player, :class_name => 'DivisionPlayer'
  belongs_to :white_player, :class_name => 'DivisionPlayer'

end
