class RegistrationMatch < ActiveRecord::Base
  attr_accessible :black_player_id,
                  :black_player_name,
                  :division_id,
                  :match_id,
                  :registration_id,
                  :white_player_id,
                  :white_player_name,
                  :winner_id,
                  :winner_name,
                  :game_digest

  belongs_to :division
  belongs_to :match
  belongs_to :black_player, :class_name => "Registration"
  belongs_to :white_player, :class_name => "Registration"
  belongs_to :winner, :class_name => "Registration"
end
