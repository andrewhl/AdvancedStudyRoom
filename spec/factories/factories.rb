FactoryGirl.define do

  factory :user do
    username { Faker::Internet.user_name }
    first_name "John"
    last_name "Doe"
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"
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
    handicap 0
    digest { Time.now.to_s }

    factory :match_with_tags do
      ignore do
        tags_count 1
      end

      after(:build) do |m, ev|
        FactoryGirl.build_list(:match_tag, ev.tags_count, match: m)
      end
    end
  end

  factory :match_tag do
    node 5
    phrase { '#' + Faker::HipsterIpsum.word }
  end

  factory :event do
    ruleset
    name "ASR League"
  end

  factory :event_tag do
    phrase { '#' + Faker::HipsterIpsum.word }
    event
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
      server
    end

    division

    after_build do |reg, ev|
      reg.account = FactoryGirl.build(:account, handle: ev.handle, server: ev.server || FactoryGirl.build(:server))
    end
  end

  factory :server do
    name "KGS"
    url "http://example.com/"
  end

end