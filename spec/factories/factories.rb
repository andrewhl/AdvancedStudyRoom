FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email "johndoe@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  sequence :name do |n|
    "Person #{n}"
  end
end