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

  factory :ruleset, :class => Ruleset do
    name "KGS Default"
    allowed_rengo false
    allowed_teaching false
    allowed_review false
    allowed_free true
    allowed_rated true
    allowed_simul true
    allowed_demonstration false
    main_time_min 300.0
    main_time_max 2700.0
    overtime_required true
    jovertime_allowed true
    covertime_allowed true
    jot_min_periods 5
    jot_max_periods 30
    jot_min_period_length 60.0
    jot_max_period_length 300.0
    cot_min_stones 25
    cot_max_stones 25
    cot_max_time 300.0
    cot_min_time 300.0
    games_per_player 2
    games_per_opponent 2
    canonical true
    max_komi 6.5
    min_komi 6.5
    max_handi 5
    min_handi 0
    handicap_required false
  end

  factory :event_ruleset, :class => EventRuleset do
    name "Event Ruleset"
  end

  factory :tier_ruleset, :class => TierRuleset do
    name "Tier Ruleset"
  end

  factory :empty_division_ruleset, :class => DivisionRuleset do
    name "Empty Division Ruleset"
  end

  factory :division_ruleset, :class => DivisionRuleset do
    name "Division Ruleset"
    main_time_min 300.0
    main_time_max 2700.0
    overtime_required true
    jovertime_allowed true
    covertime_allowed true
    jot_min_periods 5
    jot_max_periods 30
    jot_min_period_length 60.0
    jot_max_period_length 300.0
    cot_min_stones 25
    cot_max_stones 25
    cot_max_time 300.0
    cot_min_time 300.0
    games_per_player 2
    games_per_opponent 1
    max_komi 6.5
    min_komi 5.5
    max_handi 5
    min_handi 0
    handicap_required false
  end

  factory :match, :class => Match do
    datetime_completed "#{Time.now.strftime("%Y-%m-%d %T")}"
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
    handicap 0
    game_digest "5fed482a6963e7efce38986906b687fb"
  end

  factory :second_match, :class => Match do
    datetime_completed "#{Time.now.strftime("%Y-%m-%d %T")}"
    black_player_id 11
    white_player_id 18
    black_player_name "kabradarf"
    white_player_name "twisted"
  end


end