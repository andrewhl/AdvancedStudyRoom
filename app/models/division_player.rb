# == Schema Information
#
# Table name: division_players
#
#  id            :integer          not null, primary key
#  division_id   :integer
#  kgs_handle_id :integer
#  points        :float
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DivisionPlayer < ActiveRecord::Base
  attr_accessible :division_id, :kgs_handle_id, :points, :status

  belongs_to :division
  belongs_to :kgs_handle


  def matches
    Match.where('black_player_id = ? or white_player_id = ?', self.id, self.id)
  end
end
