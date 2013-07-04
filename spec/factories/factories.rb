FactoryGirl.define do

  factory :account do
    server
    handle { Faker::Internet.user_name }
    rank { Random.rand(-30..9) }
  end

  factory :event do
    ruleset
    name "ASR League"
  end

  factory :event_tag do
    phrase { '#' + Faker::HipsterIpsum.word }
    event
  end

  factory :match do
    digest { Time.now.to_s }
    completed_at {"#{Time.now.strftime("%Y-%m-%d %T")}"}

    after(:build) do |m, ev|
      m.match_detail = FactoryGirl.build(:match_detail)
    end

    # factory :match_with_tags do
    #   ignore do
    #     tags_count 1
    #   end

    #   after(:build) do |m, ev|
    #     FactoryGirl.build_list(:match_tag, ev.tags_count, match: m)
    #   end
    # end
  end

  factory :match_detail do
    komi 6.5
    win_info "Resign"
    main_time_control 2400.0
    handicap 0
  end

  factory :match_tag do
    node 5
    phrase { '#' + Faker::HipsterIpsum.word }
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

  factory :server do
    name "KGS"
    url "http://www.example.com"
  end

  factory :user do
    username { Faker::Internet.user_name }
    first_name "John"
    last_name "Doe"
    email { Faker::Internet.email }
    password "foobar"
    password_confirmation "foobar"
  end

end
