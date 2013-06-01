# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match_tag do
    node 1
    match_id 1
    phrase "MyString"
    handle "MyString"
  end
end
