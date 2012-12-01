# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment, :class => 'Comments' do
    match_id 1
    node 1
    comment "MyString"
  end
end
