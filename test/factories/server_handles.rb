# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :server_handle do
    user_id 1
    server_handle "MyString"
    league_tier 1
    league_active 1
    rank 1
  end
end
