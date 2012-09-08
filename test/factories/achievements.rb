# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :achievement do
    achievement_name "MyString"
    earned_image_url "MyString"
    pending_image_url "MyString"
  end
end
