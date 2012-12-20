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

  factory :match, :class => Match do
    datetime_completed "2012-10-09 00:00:00"
    komi 6.5
    winner "W"
    win_info "Resign"
    main_time_control 2400.0
    overtime_type "byo-yomi"
    ot_stones_periods 30
    ot_time_control 5.0
    black_player_id 18
    white_player_id 11
    black_player_name "twisted"
    white_player_name "kabradarf"
    handicap nil
    game_digest "5fed482a6963e7efce38986906b687fb"
  end

end