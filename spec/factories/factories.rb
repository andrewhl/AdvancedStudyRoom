FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Doe"
    email "johndoe@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :test_account do
    handle "kabradarf"
    user
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  sequence :name do |n|
    "Person #{n}"
  end

  factory :admin, :class => User do
    first_name "Admin"
    email "admin@admin.com"
    password "foobar"
    password_confirmation "foobar"
    admin true
  end

end