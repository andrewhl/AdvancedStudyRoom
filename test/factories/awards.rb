# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :award do
    user_id 1
    achievement_id 1
    date_awarded "2012-09-06 11:03:00"
  end
end
