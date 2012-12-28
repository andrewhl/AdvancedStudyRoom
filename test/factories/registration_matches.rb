# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration_match do
    registration_id 1
    match_id 1
    black_player_id 1
    white_player_id 1
    black_player_name "MyString"
    white_player_name "MyString"
    winner_id 1
    winner_name "MyString"
    division_id 1
  end
end
