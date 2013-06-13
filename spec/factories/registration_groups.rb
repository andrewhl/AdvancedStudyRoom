# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration_group do
    event_id 1
    registration_group_type_id "MyString"
    integer "MyString"
    parent_id 1
    name "MyString"
    min_registrations 1
    max_registrations 1
  end
end
