#
# ADMIN
#

if User.find_by_email('admin@test.com').nil?
  puts 'Creating admin user...'
  User.create(
    { first_name: 'admin',
      username: 'admin',
      email: 'admin@test.com',
      password: 'admin',
      admin: true },
    without_protection: true)
end

#
# SERVERS
#

unless kgs_server = Server.find_by_name('KGS')
  puts 'Creating KGS server...'
  kgs_server = Server.create(
    { name: 'KGS',
      url: 'www.gokgs.com',
      scraper_class_name: 'KgsScraper'},
    without_protection: true)
end


unless Server.exists?(name: 'Kaya')
  puts 'Creating Kaya server...'
  Server.create(name: 'Kaya')
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
  j_ot_max_periods: 60,
  j_ot_min_period_length: 5,
  j_ot_max_period_length: 300,
  c_ot_min_stones: 25,
  c_ot_max_stones: 100,
  c_ot_max_time: 300,
  c_ot_min_time: 300,
  min_handicap: 0,
  max_handicap: 0}

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
      point_decay: 0.5,
      max_matches_per_opponent: 2,
      min_points_per_match: 0.5)
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

#
# USERS
#

all_users = {
  'Alpha 1' =>  ['redreoicy', 'skeletor', 'soutkin', 'zischty', 'prue', 'compgo74', 'nathan', 'geser', 'hernan1987', 'joenosai', 'jhyn', 'treeoflife', 'drgoplayer', 'bleen', 'ghaele', 'xpillow', 'tilwen', 'kokuryu'],
  'Beta 1' =>   ['rosenzweig', 'laurels', 'lowlander', 'faceless1', 'bradypus', 'antek', 'christianb', 'lilias', 'karaskun', 'nguyenvu90', 'calm', 'mibagent', 'sinister', 'nynfas', 'konservas', 'atheri', 'elnino94', 'csendelet', 'yurisch', 'agzam'],
  'Beta 2' =>   ['explo', 'nh3ch2cooh', 'kemist', 'felix24', 'amigo', 'leaves', 'apoplexie', 'braket', 'climu', 'dr4ch3', 'baboon', 'chemboy613', 'peaceful', 'thegame', 'vectnik', 'gorussia', 'lion', 'mishik', 'ohatsu', 'spook'],
  'Gamma 1' =>  ['katake', 'fratloev', 'greyghost', 'clemantis', 'liberson', 'sheriffi', 'ravurirane', 'acceptance', 'astrix', 'waynec', 'krazulz', 'sylaris', 'mendieta', 'nannyogg', 'terranigma', 'dedyz', 'lukaszb', 'sebastien', 'rukis', 'bengozen', 'cadet354', 'kitsune', 'kolibry', 'vorador', 'galthranne'],
  'Gamma 2' =>  ['lifesystem', 'gigantom', 'dmitriy81', 'guishu', 'nebilim', 'horner', 'shisu', 'atmaca', 'cava93', 'ryuujin', 'taikobara', 'aertan', 'kerstin', 'stalkor', 'bert', 'pierrebo', 'knight', 'bensenseii', 'thesirjay', 'xdmistakes', 'kwinin', 'cheesecake', 'coreon', 'menhir', 'schueling', 'seitogo'],
  'Gamma 3' =>  ['daimaouyun', 'lit', 'georgew', 'saqua', 'cb22', 'goatsunday', 'yakami', 'curi', 'plain', 'korauz', 'bufrisa', 'avicenna', 'lafayette', 'mrmago', 'taner', 'affytaffy', 'ketler', 'niscend', 'theworld', 'vlad3333', 'yeastbeast', 'dragonlost', 'fungosage', 'hushfield', 'ragnhild', 'tsuijin'],
  'Gamma 4' =>  ['leothelion', 'yannick123', 'danielxr', 'turingtest', 'aperezwi', 'chrism', 'mac48', 'girei', 'greenbean', 'kranich', 'bunrun11', 'psitheta', 'novus', 'mysto', 'splatted', 'spudx', 'eyeliner', 'goldbird', 'isley', 'qsg', 'sara', 'babaji', 'dragoness', 'ketzchen', 'stevek'],
  'Delta 1' =>  ['humblelife', 'moin9', 'tasteless', 'tcj', 'thesun', 'bagua', 'hailthorn', 'tsquared', 'mitvailer', 'boule', 'pont', 'tokee', 'scatcat', 'umbra', 'liq3', 'kalin1', 'tjw', 'thedark', 'orlxnxhn', 'frago', 'go2where', 'noruego', 'dsaws', 'andyrease', 'proomas', 'shi', 'dlayn', 'backpack1', 'shndhkr', 'mtarn567', 'artshx', 'moses', 'whitenoise', 'braa', 'zogleheros', 'whitelotus', 'azuli', 'luckyjim', 'marta', 'mous2410', 'hatsune', 'lucpalmas', 'alvagofm', 'schrody', 'zeekmund', 'rash22', 'tobsucht', 'ohiogonoob', 'davy014', 'monsieurb', 'ralf08', 'deadpool1', 'chanjub', 'hantavirus', 'petern', 'sshiva12', 'mhdef1', 'vdk', 'nijura', 'pytta', 'mathfreak', 'pegaseo', 'elliott', 'emberobin', 'luffy63', 'sens', 'jayy', 'bluemagic', 'mrbig', 'metropolis', 'eeinsei', 'trethtzer', 'brittany', 'brodiaga', 'ciaso', 'juniper04', 'kiwon', 'lebertran', 'olaf', 'owle', 'rykage', 'xirxaven', 'yopai', 'hericfox', 'bedanc', 'loganmhb', 'kigf', 'lahtis', 'djllap', 'orballo']
}

max_users_per_division = 10
divisions = asr_league_event.divisions

all_users.each do |division_name, usernames|
  division = asr_league_event.divisions.where(name: division_name).first
  next unless division

  usernames.each do |username|
    user = User.find_by_username(username, include: :accounts)

    # CREATE USER

    if user.blank?
      puts "Creating #{username} user..."
      user = User.create(
        username: username,
        first_name: username,
        email: "#{username}@example.com",
        password: username)
    end

    # CREATE USER ACCOUNT

    account = user.accounts.where(server_id: kgs_server.id).first
    if account.blank?
      puts "Creating #{username} account..."
      account = user.accounts.create(
        { server: kgs_server,
          handle: username,
          rank: 1 },
        without_protection: true)
    end

    # CREATE ACCOUNT REGISTRATION

    registration = account.registrations.where(event_id: asr_league_event.id)
    if registration.blank?
      puts "Creating #{username} registration to #{division_name}..."
      account.registrations.create(
        { event: asr_league_event,
          division: division },
        without_protection: true)
    end
  end
end
