# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point_ruleset do
    parent_id 1
    parent_id "MyString"
    points_per_win 1.5
    points_per_loss 1.5
    point_decay 1.5
    games_per_opponent 1
    type ""
  end
end
