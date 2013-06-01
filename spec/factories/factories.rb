FactoryGirl.define do

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  sequence :name do |n|
    "Person #{n}"
  end

  factory :user do
    username "johndoe"
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

  factory :account do
    server
    handle { Faker::Internet.user_name }
    rank { Random.rand(-30..9) }
  end


  factory :ruleset do
    name "KGS Default"
    main_time_min 300.0
    main_time_max 2700.0
    overtime_required false
    j_ot_allowed false
    c_ot_allowed false
    j_ot_min_periods 5
    j_ot_max_periods 30
    j_ot_min_period_length 60.0
    j_ot_max_period_length 300.0
    c_ot_min_stones 25
    c_ot_max_stones 25
    c_ot_max_time 300.0
    c_ot_min_time 300.0
    max_komi 6.5
    min_komi 6.5
    max_handicap 5
    min_handicap 0
    handicap_required false
  end


  factory :match do
    completed_at {"#{Time.now.strftime("%Y-%m-%d %T")}"}
    komi 6.5
    win_info "Resign"
    main_time_control 2400.0
    black_player
    white_player
    match_tag
    handicap 0
    digest { Time.now.to_s }
  end

  factory :match_tag do
    node 5
    phrase "#ASR"
  end

  factory :event do
    ruleset
    name "ASR League"
  end

  factory :tier do
    event
    ruleset
    name "Alpha"
    factory :beta_tier do
      name "Beta"
    end
  end


  factory :division do
    tier
    ruleset
    minimum_players 2
    maximum_players 50
    index 1

    factory :beta_division do
      association :tier, factory: :beta_tier
    end
  end

  factory :registration, :aliases => [:black_player, :white_player] do
    ignore do
      handle { Faker::Internet.user_name }
    end

    account
    division

    after_build do |reg, ev|
      reg.account.update_attribute :handle, ev.handle
    end
  end

  factory :server do
    name "KGS"
  end

end