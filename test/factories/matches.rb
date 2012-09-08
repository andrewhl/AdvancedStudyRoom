# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match do
    black_player 1
    white_player 1
    datetime_completed "2012-09-06 11:08:39"
    game_type "MyString"
    komi 1.5
    result "MyString"
    main_time_control 1.5
    overtime_type "MyString"
    ot_stones_periods 1
    ot_time_control 1.5
    url "MyString"
  end
end
