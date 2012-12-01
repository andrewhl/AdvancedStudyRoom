# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :point do
    count 1
    account_id 1
    event_desc "MyString"
    event_type "MyString"
  end
end
