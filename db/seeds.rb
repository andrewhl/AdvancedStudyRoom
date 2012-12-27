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

alpha_users = ["baboon", "chemboy613", "compgo74", "dr4ch3", "drgoplayer", "gleek", "goldbird", "gorobei", "hernan1987", "kabradarf", "kanmuru", "keitarokun", "redreoicy", "sita", "socratease", "titanpupil", "twisted", "whuang"]

all_users = ["waboon", "chemboy613", "compgo74", "dr4ch3", "drgoplayer", "gleek", "goldbird", "gorobei", "hernan1987", "kabradarf", "kanmuru", "keitarokun", "redreoicy", "sita", "socratease", "titanpupil", "twisted", "whuang", "akagi", "bethestone", "bolko", "braa", "danielxr", "dragoness", "geser", "lowlander", "monk316", "mw42", "nebilim", "plain", "reepicheep", "soutkin", "timotamo", "ukiyo", "usagi", "vandalis", "vectnik", "zeekmund", "bengozen", "cararam11", "dedyz", "explo", "jayy", "kwinin", "leaves", "mapuche27", "mendieta", "nannyogg", "nathan", "nh3ch2cooh", "rapt", "rottenhat", "rpchuang", "saqua", "turingtest", "ufo", "vdk", "waynec", "aperezwi", "arroc", "babolat", "bufrisa", "calm", "ciaso", "conankudo3", "elligain", "eventy", "freehold", "humblelife", "irises", "johnboy", "kemist", "komulink38", "maou", "mathmaz", "michelxy", "nazril", "ribab", "spartaaaaa", "tilwen", "uncoil", "vladxnev", "wrathful", "agzam", "anatoly", "antek", "bentaye", "chente00", "detect", "dragoneye", "ez4u", "goldgarden", "hanen", "horner", "ijoka", "jb33", "kamanari", "lafayette", "laurels", "magnus86", "mdm", "momochan", "pavl007", "pauzle", "ryuujin", "scatcat", "watchingo", "wema", "xgoplayer", "lebertran", "aka179", "anotherday", "bryenb", "dsaws", "christianb", "domini1000", "fayt", "gigantom", "himora", "hushfield", "icanflylol", "kobutz", "kranich", "krazulz", "nano", "oldyew", "pablorr", "rime", "rykage", "mitvailer", "lit", "nayaeaude", "sara", "shika12", "suteru", "tsukime", "as91", "blue", "byakuran", "cyril", "davince", "davy014", "eeveem", "emerick", "faceless1", "fua", "freak", "joseki", "jr4ya", "lisztbach", "lord", "mag121", "otakujack", "rafannabis", "saturdayz", "thesirjay", "vierbaum", "wildplants", "yadeehoo", "yannick123", "zebra131", "druid", "adius", "aguess", "allara", "anhtuan", "antoinem", "bjondro", "boshy", "coreon", "detritus", "doiel", "dreamc", "dropbear", "duakers", "dukedaniel", "fogrob", "frodwith", "gwofu", "griagor", "hdfdirlvf", "horsti", "inrm", "jonago1", "julbla", "kalin1", "kenpruitt", "kickaha", "mejinsai", "mic", "moussepi", "naishin", "quinn", "qingshui", "renchin", "rukis", "sage", "selpahi", "sheriffi", "shrestha", "slowpoka", "tom111", "trethtzer", "tytalus", "waya1258", "viscontino", "saiomega", "strlov", "swizzle", "tgontg", "tiansrealm", "vanille", "vsl", "whitenoise", "tan", "remix", "orbix19", "aceshigh", "kirmoar", "konservas", "nkenzo", "path", "goatsunday", "awakewise", "tenshi12", "novus", "melaleuca", "therookie", "benjamingl", "kiroshisan", "invader", "quirra", "madavenger", "moboy78", "nkrach", "netsujo", "mrmago", "fight4pro", "tin", "danz", "koyou", "miyuki", "vallkan", "stonedplay", "uchihatobi", "modoki", "affytaffy", "kadoban", "totoshi", "hollumber", "img", "kratos35", "nosabe", "robertt", "leothelion", "ed", "curi", "anik", "vogdush", "togofwd", "leok", "lance123", "benjamind", "twitchygo", "ricopanda", "pegaseo", "ddkyu", "go4fever", "elliott", "mrdingo", "millstone", "billywoods", "actorios"]

all_users.length.times do |n|
  unless user = User.find_by_email("test_user#{n}@test.com")
    user = User.create(username: "#{all_users[n]}", first_name: "Test#{n}", email: "test_user#{n}@test.com", password: "testtest")
  end

  unless all_users[n].nil?
    account = user.accounts.create(rank: 1, handle: all_users[n], server_id: 1) unless Account.find_by_handle(all_users[n])
  end

  # Create the seed Event (ASR League), if it doesn't exist

  unless @event = Event.find_by_name("ASR League")
    @event = Event.create(name: "ASR League",
                         server_id: 1,
                         ruleset_id: Ruleset.find_by_name("KGS Default").id)
    @event.create_event_ruleset
  end

  unless Registration.find_by_account_id(user.accounts.first.id)
    registration = Registration.create(account_id: user.accounts.first.id,
                                       event_id: @event.id,
                                       handle: user.accounts.first.handle)
  end

end