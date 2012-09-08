class DivisionPlayer < ActiveRecord::Base
  attr_accessible :division_id, :kgs_handle_id, :points, :status

  belongs_to :division
  belongs_to :kgs_handle


  def matches
    Match.where('black_player_id = ? or white_player_id = ?', self.id, self.id)
  end
end
