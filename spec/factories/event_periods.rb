# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_period do
    name "MyString"
    starting_at "2013-05-22 13:16:08"
    ending_at "2013-05-22 13:16:08"
    event_id 1
  end
end
