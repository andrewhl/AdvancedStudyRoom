# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kgs_handle do
    user_id 1
    kgs_handle "MyString"
    league_tier 1
    league_active 1
    kgs_rank 1
  end
end
