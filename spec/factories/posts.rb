# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    html "MyText"
    user_id 1
    date "2013-05-21 12:50:39"
    title "MyString"
  end
end
