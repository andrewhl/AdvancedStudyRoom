# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tier do
    tier_type_id 1
    promotions 1
    demotions 1
    tier_hierarchy_position 1
    divisions 1
    max_games_per_player 1
    max_games_per_opponent 1
    points_per_win 1.5
    points_per_loss 1.5
    event_id 1
  end
end
