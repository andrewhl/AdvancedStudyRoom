# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if User.find_by_email("admin@test.com").nil?
  puts "Creating admin user..."
  User.create(first_name: "admin", email: "admin@test.com", password: "foobar")
end

Server.find_or_create_by_name("KGS")
Server.find_or_create_by_name("Kaya")

if Ruleset.find_by_name("KGS Default").nil?
  puts "Creating ruleset..."
  Ruleset.create(name: "KGS Default",
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
                 points_per_win: 2.0,
                 points_per_loss: 1.0,
                 canonical: true)
end


# Create the seed Event (ASR League), if it doesn't exist

unless @event = Event.find_by_name("ASR League")
  puts "Creating ASR League..."
  @event = Event.create(name: "ASR League",
                       server_id: 1,
                       ruleset_id: Ruleset.find_by_name("KGS Default").id)
  @event_ruleset = @event.create_event_ruleset(:ruleset_id => @event.ruleset.id, :parent_id => @event.ruleset.id, :node_limit => 100)
end

unless Tag.find_by_phrase("ASR League")
  Tag.create(:phrase => "ASR League", :event_id => @event.id, :event_type => "League", :node_limit => 100)
end

if @event.tiers.empty?
  puts "Creating tiers..."
  tiers = %w{Alpha Beta Gamma Delta}
  tiers.each_with_index do |tier, index|
    new_tier = @event.tiers.create(:name => tier, :tier_hierarchy_position => index + 1)
    @tier_ruleset = new_tier.create_tier_ruleset(:parent_id => @event_ruleset.id)
  end
end



# Create all the divisions, and give them a division_index (relative position inside tier, 1 is top, 2 is below that, etc.)
def division_create tier, count
  count.times do |n|
    unless tier.divisions.find_by_name(tier.name + " #{n + 1}")
      puts "Creating #{tier.name} #{n + 1}..."
      new_division = tier.divisions.create(:name => tier.name + " #{n + 1}",
                    :division_index => n + 1,
                    :minimum_players => 2,
                    :maximum_players => 200,
                    :event_id => @event.id)
      @division_ruleset = new_division.create_division_ruleset!(:parent_id => tier.ruleset.id)
    end


  end
end

# Specify the number of divisions for each tier

@event.tiers.each do |tier|
  count = 0
  case tier.name
  when "Alpha"
    count = 1
  when "Beta"
    count = 2
  when "Gamma"
    count = 4
  when "Delta"
    count = 1
  end

  division_create(tier, count)
end

alpha = ["nh3ch2cooh","jayy","dedyz","explo","lowlander","mw42","vandalis","zeekmund","chemboy613","compgo74","gleek","goldbird","hernan1987","kabradarf","redreoicy","sita","twisted","ufo"]
beta_i = ["as91","byakuran","faceless1","anotherday","oldyew","mitvailer","mdm","anatoly","tilwen","agzam","baboon","dr4ch3","drgoplayer","gorobei","bolko","danielxr","geser","plain","soutkin","vectnik"]
beta_ii = ["calm","komulink38","humblelife","antek","chente00","ryuujin","rykage","tsukime","lit","yannick123","druid","keitarokun","socratease","titanpupil","whuang","bengozen","mapuche27","nathan","saqua","turingtest"]
gamma_i = ["braa","cararam11","kwinin","leaves","novus","konservas","nkenzo","nkrach","robertt","allara","dukedaniel","kadoban","tenshi12","kratos35","rukis","coreon","trethtzer","mejinsai","aperezwi","eventy","freehold","irises","kemist","mathmaz","uncoil"]
gamma_ii = ["ukiyo","mendieta","nannyogg","togofwd","whitenoise","leothelion","ed","koyou","actorios","orbix19","therookie","tin","img","leok","hollumber","danz","affytaffy","ez4u","horner","ijoka","lafayette","laurels","magnus86","momochan","lebertran","wiles"]
gamma_iii = ["monk316","rapt","rottenhat","anik","doiel","fight4pro","quirra","kalin1","quinn","kirmoar","ricopanda","billywoods","pegaseo","bjondro","tan","aceshigh","stonedplay","curi","invader","christianb","domini1000","gigantom","kranich","nano","sara","owen"]
gamma_iv = ["timotamo","waynec","rpchuang","gwofu","julbla","elliott","antoinem","awakewise","netsujo","tom111","kwinsure","ed2antes","hanabusa","revelation","oin","joseki","davy014","eeveem","emerick","freak","lord","rafannabis","thesirjay","yurisch","uriel"]
delta = ["asbag","avicenna","atheri","bottleneck","chuibete","nosabe","nottengen","nuclear","storn","thegame","zischty","michelxy","vladxnev","wrathful","arroc","babolat","bufrisa","ribab","johnboy","pavl007","pauzle","goldgarden","xgoplayer","pablorr","aka179","nayaeaude","cyril","fua","jr4ya","mag121","zebra131","glasszee","maximg","skeletor","malie","twitchygo","weakgo","tmath","zs","testplay09","urg","fayt","agony","yusakukudo","mrmago","libertad","jenj","prue","googolplex","eiszaepfle","cylonbuney","diy","cofeebreak","vogdush","alphanum","dmitriy81","vrnbugatti","zzzzzzz22","trudeln","amakaresu","timk","marcus316","pont","brodiaga","hailthorn","only4fun","barrauss","odin1337","rayheart","xdmistakes","erdbeere","modoki","fpqc","drankel","csendelet","cptidiot","takahira","cadet354","viator","adamcb","panterka","ganta","kosach","ciaso","joenosai","tacitus","schui4i","stefan799"]

all_users = {"Alpha 1" => alpha,
             "Beta 1" => beta_i,
             "Beta 2" => beta_ii,
             "Gamma 1" => gamma_i,
             "Gamma 2" => gamma_ii,
             "Gamma 3" => gamma_iii,
             "Gamma 4" => gamma_iv,
             "Delta 1" => delta}

@divisions = @event.divisions

puts "Creating division point rulesets..."
@divisions.each do |division|
  if division.point_ruleset.nil?
    puts "Creating point ruleset for #{division.name}..."
    @point_ruleset = PointRuleset.create(:parent_id => division.id,
                  :points_per_win => 2.0,
                  :points_per_loss => 1.0,
                  :point_decay => 0.5,
                  :points_per_game => 0.5,
                  :parent_type => "Division")
  end
end

puts "Going through users..."
index = 0
all_users.each do |name, division|


  puts "Division name: \t\t#{name}"
  division.length.times do |n|

    # binding.pry if division[n] == "akagi"
    unless user = User.find_by_username(division[n])
      puts "Creating user: #{division[n]}"
      user = User.create(username: "#{division[n]}", first_name: "#{name} Test#{n}", email: "#{name.gsub(/\s/, '')}test_user#{n}@test.com", password: "testtest")
    end

    # binding.pry if name == "Beta 1" and n == 1
    unless division[n].nil? # don't do this if the name is nil
      puts "Creating user accounts for #{division[n]}"
      account = user.accounts.create(rank: 1,
                    handle: division[n].downcase,
                    display_name: division[n],
                    server_id: 1) unless Account.find_by_handle(division[n])
    end

    unless Registration.find_by_account_id(user.accounts.first.id)
      puts "Creating registration for #{division[n]}"
      registration = Registration.create(account_id: user.accounts.first.id,
                                         event_id: @event.id,
                                         handle: user.accounts.first.handle,
                                         display_name: user.accounts.first.display_name,
                                         division_id: @divisions.find_by_name(name).id)
    end
  end
end
