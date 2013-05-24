# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    date "2013-05-23 20:28:26"
    user_id 1
    html "MyString"
    title "MyString"
  end
end
