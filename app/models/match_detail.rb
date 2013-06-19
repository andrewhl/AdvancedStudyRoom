# == Schema Information
#
# Table name: match_details
#
#  id                :integer          not null, primary key
#  match_id          :integer
#  ot_stones_periods :integer
#  board_size        :integer
#  handicap          :integer
#  type              :string(100)
#  ot_type           :string(100)
#  win_info          :string(100)
#  filename          :string(255)
#  black_player_name :string(100)
#  white_player_name :string(100)
#  komi              :float
#  main_time_control :float
#  ot_time_control   :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class MatchDetail < ActiveRecord::Base
  belongs_to :match


  def byo_yomi?
    ot_type == Match::BYO_YOMI
  end

  def canadian?
    ot_type == Match::CANADIAN
  end

end
