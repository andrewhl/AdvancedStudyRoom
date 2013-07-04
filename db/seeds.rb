#
# ADMIN
#

unless User.exists?(admin: true)
  puts 'Creating admin user...'
  User.create(
    first_name: 'admin',
    username: 'admin',
    email: 'admin@test.com',
    password: 'admin1',
    password_confirmation: 'admin1',
    admin: true)
end

#
# SERVERS
#

unless kgs_server = Server.find_by_name('KGS')
  puts 'Creating KGS server...'
  kgs_server = Server.create(
    name: 'KGS',
    url: 'www.gokgs.com',
    scraper_class_name: 'KgsScraper::Scraper')
end

#
# RULESET ATTRS
#

ruleset_attrs = {
  name: 'KGS Default',
  main_time_min: 1500,
  main_time_max: 5400,
  overtime_required: true,
  j_ot_allowed: true,
  c_ot_allowed: true,
  j_ot_min_periods: 5,
  j_ot_max_periods: 100,
  j_ot_min_period_length: 5,
  j_ot_max_period_length: 300,
  c_ot_min_stones: 25,
  c_ot_max_stones: 100,
  c_ot_max_time: 300,
  c_ot_min_time: 300,
  min_handicap: 0,
  max_handicap: 0,
  node_limit: 100}

#
# ASR LEAGUE EVENT
#

unless asr_league_event = Event.find_by_name('ASR League')
  puts 'Creating ASR League event...'
  asr_league_event = Event.create(
    { name: 'ASR League',
      event_type: 'League',
      server: kgs_server },
    without_protection: true)
  asr_league_event.create_ruleset!(ruleset_attrs.merge(name: "ASR League", rulesetable_type: 'Event'))
end


unless asr_league_event.point_ruleset.present?
  puts "Creating #{asr_league_event} point ruleset..."

  asr_league_event.create_point_ruleset(
      points_per_win: 2.0,
      points_per_loss: 1.0,
      win_decay: 0.5,
      loss_decay: 0.5,
      max_matches_per_opponent: 2,
      min_points_per_match: 0)
end

#
# ASR LEAGUE TAG
#

asr_leage_tags = ['#asr', '#asrleague']
asr_leage_tags.each do |phrase|
  next if EventTag.find_by_phrase(phrase)
  puts 'Creating ASR League tag...'
  EventTag.create({phrase: phrase, event: asr_league_event, node_limit: 100}, without_protection: true)
  EventTag.create({phrase: phrase, event: asr_league_event, node_limit: 100}, without_protection: true)
end

#
# ASR LEAGUE TIERS
#

%w{Alpha Beta Gamma Delta}.each_with_index do |name, index|
  next if asr_league_event.tiers.find_by_name(name).present?
  puts "Creating ASR League #{name} tier..."
  tier = asr_league_event.tiers.create(name: name, index: index + 1)
  tier.create_ruleset(name: "ASR League #{name}", rulesetable_type: 'Tier')
end

#
# ASR LEAGUE DIVISIONS
#

def create_divisions(tier, count)
  count.times do |n|
    div_index = n + 1
    div_name = "#{tier.name} #{div_index}"
    next if tier.divisions.find_by_name(div_name).present?
    puts "Creating #{div_name} division..."
    division = tier.divisions.create!(
      { name: div_name,
        index: div_index,
        minimum_players: 2,
        maximum_players: 200},
      without_protection: true)
    division.create_ruleset!(name: "ASR League #{div_name}", rulesetable_type: 'Division')
  end
end


asr_league_event.tiers.each do |tier|
  count = case tier.name
    when 'Alpha' then 1
    when 'Beta'  then 2
    when 'Gamma' then 4
    when 'Delta' then 1
    else 0
  end

  create_divisions(tier, count) if count > 0
end

asr_league_event.divisions.each do |division|
  next unless division.point_ruleset.nil?
  division.create_point_ruleset()
end


