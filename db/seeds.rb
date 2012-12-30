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

Tag.find_or_create_by_phrase("ASR League")

if Ruleset.find_by_name("KGS Default").nil?
  puts "Creating ruleset..."
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

# Create the seed Event (ASR League), if it doesn't exist

unless @event = Event.find_by_name("ASR League")
  puts "Creating ASR League..."
  @event = Event.create(name: "ASR League",
                       server_id: 1,
                       ruleset_id: Ruleset.find_by_name("KGS Default").id)
  @event.create_event_ruleset
end

if @event.tiers.empty?
  puts "Creating tiers..."
  tiers = %w{Alpha Beta Gamma Delta}
  tiers.each_with_index do |tier, index|
    new_tier = @event.tiers.create(:name => tier, :tier_hierarchy_position => index)
    new_tier.create_tier_ruleset
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
      new_division.create_division_ruleset
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

alpha = ["baboon", "chemboy613", "compgo74", "dr4ch3", "drgoplayer", "gleek", "goldbird", "gorobei", "hernan1987", "kabradarf", "kanmuru", "keitarokun", "redreoicy", "sita", "socratease", "titanpupil", "twisted", "whuang"]
beta_i = ["akagi", "bethestone", "bolko", "braa", "danielxr", "dragoness", "geser", "lowlander", "monk316", "mw42", "nebilim", "plain", "reepicheep", "soutkin", "timotamo", "ukiyo", "usagi", "vandalis", "vectnik", "zeekmund"]
beta_ii = ["bengozen", "cararam11", "dedyz", "explo", "jayy", "kwinin", "leaves", "mapuche27", "mendieta", "nannyogg", "nathan", "nh3ch2cooh", "rapt", "rottenhat", "rpchuang", "saqua", "turingtest", "ufo", "vdk", "waynec"]
gamma_i = ["aperezwi", "arroc", "babolat", "bufrisa", "calm", "ciaso", "conankudo3", "elligain", "eventy", "freehold", "humblelife", "irises", "johnboy", "kemist", "komulink38", "maou", "mathmaz", "michelxy", "nazril", "ribab", "spartaaaaa", "tilwen", "uncoil", "vladxnev", "wrathful", "agzam"]
gamma_ii = ["anatoly", "antek", "bentaye", "chente00", "detect", "dragoneye", "ez4u", "goldgarden", "hanen", "horner", "ijoka", "jb33", "kamanari", "lafayette", "laurels", "magnus86", "mdm", "momochan", "pavl007", "pauzle", "ryuujin", "scatcat", "watchingo", "wema", "xgoplayer", "lebertran"]
gamma_iii = ["aka179", "anotherday", "bryenb", "dsaws", "christianb", "domini1000", "fayt", "gigantom", "himora", "hushfield", "icanflylol", "kobutz", "kranich", "krazulz", "nano", "oldyew", "pablorr", "rime", "rykage", "mitvailer", "lit", "nayaeaude", "sara", "shika12", "suteru", "tsukime"]
gamma_iv = ["as91", "blue", "byakuran", "cyril", "davince", "davy014", "eeveem", "emerick", "faceless1", "fua", "freak", "joseki", "jr4ya", "lisztbach", "lord", "mag121", "otakujack", "rafannabis", "saturdayz", "thesirjay", "vierbaum", "wildplants", "yadeehoo", "yannick123", "zebra131", "druid"]
delta = ["adius", "aguess", "allara", "anhtuan", "antoinem", "bjondro", "boshy", "coreon", "detritus", "doiel", "dreamc", "dropbear", "duakers", "dukedaniel", "fogrob", "frodwith", "gwofu", "griagor", "hdfdirlvf", "horsti", "inrm", "jonago1", "julbla", "kalin1", "kenpruitt", "kickaha", "mejinsai", "mic", "moussepi", "naishin", "quinn", "qingshui", "renchin", "rukis", "sage", "selpahi", "sheriffi", "shrestha", "slowpoka", "tom111", "trethtzer", "tytalus", "waya1258", "viscontino", "saiomega", "strlov", "swizzle", "tgontg", "tiansrealm", "vanille", "vsl", "whitenoise", "tan", "remix", "orbix19", "aceshigh", "kirmoar", "konservas", "nkenzo", "path", "goatsunday", "awakewise", "tenshi12", "novus", "melaleuca", "therookie", "benjamingl", "kiroshisan", "invader", "quirra", "madavenger", "moboy78", "nkrach", "netsujo", "mrmago", "fight4pro", "tin", "danz", "koyou", "miyuki", "vallkan", "stonedplay", "uchihatobi", "modoki", "affytaffy", "kadoban", "totoshi", "hollumber", "img", "kratos35", "nosabe", "robertt", "leothelion", "ed", "curi", "anik", "vogdush", "togofwd", "leok", "lance123", "benjamind", "twitchygo", "ricopanda", "pegaseo", "ddkyu", "go4fever", "elliott", "mrdingo", "millstone", "billywoods", "actorios"]

all_users = {"Alpha 1" => alpha,
             "Beta 1" => beta_i,
             "Beta 2" => beta_ii,
             "Gamma 1" => gamma_i,
             "Gamma 2" => gamma_ii,
             "Gamma 3" => gamma_iii,
             "Gamma 4" => gamma_iv,
             "Delta 1" => delta}

@divisions = @event.divisions

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
      account = user.accounts.create(rank: 1, handle: division[n], server_id: 1) unless Account.find_by_handle(division[n])
    end

    unless Registration.find_by_account_id(user.accounts.first.id)
      puts "Creating registration for #{division[n]}"
      registration = Registration.create(account_id: user.accounts.first.id,
                                         event_id: @event.id,
                                         handle: user.accounts.first.handle,
                                         division_id: @divisions.find_by_name(name).id)
    end
  end
end
