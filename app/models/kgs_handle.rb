class KgsHandle < ActiveRecord::Base
  attr_accessible :kgs_handle, :kgs_rank, :league_active, :league_tier, :user_id

  has_one :division_player
  belongs_to :user
end
