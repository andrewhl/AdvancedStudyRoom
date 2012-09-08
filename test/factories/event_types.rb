# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event_type do
    name "MyString"
    allowed_rengo false
    allowed_teaching false
    allowed_review false
    allowed_free false
    allowed_rated false
    allowed_simul false
    allowed_demonstration false
    tag_text "MyString"
    main_time_min 1.5
    main_time_max 1.5
    overtime_required false
    jovertime_allowed false
    covertime_allowed false
    jot_min_periods 1
    jot_max_periods 1
    jot_min_period_length 1.5
    jot_max_period_length 1.5
    cot_min_stones 1
    cot_max_stones 1
    handicap_default 1.5
    ruleset_default "MyString"
    games_per_player 1
    games_per_opponent 1
  end
end
