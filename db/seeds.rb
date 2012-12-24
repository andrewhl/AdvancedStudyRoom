# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if User.find_by_email("admin@test.com").nil?
  User.create(first_name: "admin", email: "admin@test.com", password: "foobar")
end

alpha_users = ["baboon", "chemboy613", "compgo74", "dr4ch3", "drgoplayer", "gleek", "goldbird", "gorobei", "hernan1987", "kabradarf", "kanmuru", "keitarokun", "redreoicy", "sita", "socratease", "titanpupil", "twisted", "whuang"]

alpha_users.length.times do |n|
  unless user = User.find_by_email("test_user#{n}@test.com")
    user = User.create(username: "#{alpha_users[n]}", first_name: "Test#{n}", email: "test_user#{n}@test.com", password: "testtest")
  end

  unless alpha_users[n].nil?
    account = user.accounts.create(rank: 1, handle: alpha_users[n], server_id: 1) unless Account.find_by_handle(alpha_users[n])
  end

  unless Event.find_by_id(1)
    unless Registration.find_by_account_id(user.accounts.first.id)
      registration = Registration.create(account_id: user.accounts.first.id,
                                         event_id: 1,
                                         handle: user.accounts.first.handle)
    end
  end

end
Server.find_or_create_by_name("KGS")
Server.find_or_create_by_name("Kaya")
Tag.find_or_create_by_phrase("ASR League")
if Ruleset.find_by_name("KGS Default").nil?
  Ruleset.create(name: "KGS Default",
                 allowed_rengo: false,
                 allowed_teaching: false,
                 allowed_review: false,
                 allowed_free: true,
                 allowed_rated: true,
                 allowed_simul: true,
                 allowed_demonstration: false,
                 main_time_min: 300,
                 main_time_max: 2700,
                 overtime_required: true,
                 jovertime_allowed: true,
                 covertime_allowed: true,
                 jot_min_periods: 5,
                 jot_max_periods: 30,
                 jot_min_period_length: 60,
                 jot_max_period_length: 300,
                 cot_min_stones: 25,
                 cot_max_stones: 25,
                 cot_max_time: 300,
                 cot_min_time: 300,
                 min_handi: 0,
                 max_handi: 9,
                 games_per_player: 2,
                 games_per_opponent: 2,
                 canonical: true)
end

