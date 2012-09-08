# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tier_type do
    name "MyString"
    default_promotions 1
    default_demotions 1
    tier_hierarchy_position 1
    default_divisions 1
    max_games_per_player 1
    max_games_per_opponent 1
    points_per_win 1.5
    points_per_loss 1.5
  end
end
