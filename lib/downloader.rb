['net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils', 'digest/md5'].each { |x| require x }

class Downloader

  def download_games filepath, username

    Zip::ZipFile.open(filepath) do |zip_file|
      zip_file.each do |f|


        # Review games match the regex: ^\w+-\d+\.sgf|^\w+\.sgf, (e.g. username-#.sgf or just username.sgf)
        # These games should not be counted
        # binding.pry
        next if not File.basename(f.to_s).scan(/^\w+-\d+\.sgf|^\w+\.sgf/).empty?

        f_path = File.join("temp", File.basename(f.to_s))
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exists?(f_path)


        game = convert_sgf_to_game(f_path.to_s, username)

        # binding.pry if game != "Invalid"
        puts game, File.basename(f.to_s)
        unless game == "Invalid"
          # binding.pry if File.basename(f.to_s) == "ricopanda-affytaffy.sgf"
          game_comments = get_comments(f_path.to_s, game.game_digest)

          # return "Invalid game" unless game.has_valid_tag game_comments

          # binding.pry if game != "Invalid"
          if game.save

            # process the RegistrationMatch
            # unless RegistrationMatch.find_by_game_digest(game.game_digest)
            #   create_registration_match(game)
            # end

            # skip this step if for some reason this game's comments already exist
            next if game.comments.any?

            process_comments(game, game_comments)

          end
        end

        FileUtils.remove_entry(f_path)
      end
    end
  end



  def convert_sgf_to_game file, username

    parser = SGF::Parser.new
    tree = parser.parse(file)
    game = tree.games.first

    # Only converts games that contain the ASR tag in the first 30 moves

    ginfo = game.current_node.properties


    # binding.pry if file != "temp/Unbeatable-ChemBoy613.sgf"
    # binding.pry
    # return nil if not (has_valid_tag(game)[0])

    # date_time = game.date
    ruleset = game.rules
    board_size = ginfo["SZ"]
    # komi = game.komi.to_f

    # if the game is a demonstration game, game.black_player or game.white_player
    # will raise an SGF:NoIdentityError

    if ginfo["PB"].nil? or ginfo["PW"].nil?
      return "Invalid"
    end

    black_player_name = game.black_player
    white_player_name = game.white_player

    # Find the registration that matches the black and white player names.

    black_player = Registration.find_by_handle(black_player_name)
    white_player = Registration.find_by_handle(white_player_name)

    # Check that both players are registered

    return "Invalid" if !black_player or !white_player

    # Grab the id of the registration or make the id nil.

    black_player_id ||= black_player.id unless black_player.nil?
    white_player_id ||= white_player.id unless white_player.nil?

    # confirm that both players are in the same division

    return "Invalid" if black_player.division.nil? or white_player.division.nil?

    return "Invalid" unless black_player.division == white_player.division

    division_id = black_player.division.id

    # handicap = ginfo["HA"]

    # Game has no result. Presumably an escaped / unfinished game.
    return "Invalid" if ginfo["RE"].nil?

    result = ginfo["RE"].split("+")

    main_time = ginfo["TM"]

    if ginfo["OT"].nil?
      ot_type = "None"
      ot_main = 0
      ot_stones = 0
    else
      overtime = ginfo["OT"].split(" ")

      # Board size
      board_size = ginfo["SZ"].to_i

      # Type of overtime, e.g. byo-yomi, Canadian
      ot_type = overtime[1]

      # Overtime main time/periods and number of stones (e.g., 10 periods, 15 stones, or 300 seconds, 25 stones)
      ot_settings = overtime[0].split("x")

      # Always an integer; whether it represents seconds or number of periods is determined by ot_type
      ot_main = ot_settings[0]

      # Always just the number of stones per period/seconds
      ot_stones = ot_settings[1]
    end

    winner = result[0]

    case winner
    when "W"
      winner_name = white_player_name
      winner_id = white_player_id
    when "B"
      winner_name = black_player_name
      winner_id = black_player_id
    end

    win_info = result[1]

    # handicap
    handicap = 0
    handicap = ginfo["HA"] unless !ginfo["HA"]

    # game digest == sgf file name (which will be unique), and the game date

    digest_phrase = File.basename(file) + game.date.to_s
    digest = Digest::MD5.hexdigest(digest_phrase)

    # URL on KGS Archive site
    date_path = game.date.gsub(/-/, "/")
    url = "http://files.gokgs.com/games/#{date_path}/#{File.basename(file)}"

    game_hash = Hash.new
    game_hash = {
      "datetime_completed" => game.date,
      "komi" => game.komi.to_f,
      "winner" => winner,
      "win_info" => win_info,
      "main_time_control" => ginfo["TM"],
      "overtime_type" => ot_type,
      "ot_stones_periods" => ot_stones,
      "ot_time_control" => ot_main,
      "black_player_name" => black_player_name,
      "white_player_name" => white_player_name,
      "handicap" => handicap,
      "game_digest" => digest,
      "black_player_id" => black_player_id,
      "white_player_id" => white_player_id,
      "winner_id" => winner_id,
      "winner_name" => winner_name,
      "board_size" => board_size,
      "division_id" => division_id,
      "url" => url
    }

    return match = Match.new(game_hash)

  end



  def get_comments sgf, game_digest

    parser = SGF::Parser.new
    tree = parser.parse(sgf)
    game = tree.games.first

    comments = Hash.new

    # associate the comments with a specific game
    comments[:game_digest] = game_digest

    unprocessed_comments = []
    comment_group_number = 0

    # collect all the comments in the sgf file
    game.each_with_index do |node, index|
      next unless node.properties["C"]
      # binding.pry
      unprocessed_comments << node.properties["C"].split("\n")
      unprocessed_comments[comment_group_number] << index
      comment_group_number += 1

    end

    # Return nil if the game has no comments
    return nil if unprocessed_comments.empty?

    # in an sgf file there may be multiple coments per sgf node (i.e., move)
    # so I am looping through them here
    unprocessed_comments.each do |comment_group|
      # binding.pry
      line_number = 1

      # here I am processing each individual comment,
      # and assigning them each to a hash
      comment_group.each do |comment|

        # Skip because last line in comment is the node number
        next if comment.is_a? Fixnum

        handle = comment.scan(/^[a-zA-Z0-9]+/).pop
        rank = comment.scan(/\[([\d]+[d|k]|[\d]+[d|k]\?|\?|\-)\]/).flatten.pop
        processed_comment = comment.scan(/\:\s(.+)/).flatten.pop
        game_date = game.date
        node_number = comment_group.last
        comment_hash = {
                  handle: handle,
                  rank: rank,
                  comment: processed_comment,
                  game_date: game_date
        }
        if comments[:"node_#{node_number}"]
          comments[:"node_#{node_number}"] = comments[:"node_#{node_number}"].merge :"line_#{line_number.to_s}" => comment_hash
        else
          comments[:"node_#{node_number}"] = { :"line_#{line_number.to_s}" => comment_hash }
        end
        # binding.pry

        line_number += 1
      end
    end

    # binding.pry if game.black_player == "twisted" and game.date != "2012-10-09"
    # binding.pry if game.date == "2012-10-03"
    comments

  end



  def create_registration_match game

    division = game.division
    registrations = division.registrations

    # search the existing game's division's registrations;
    # no duplicate handles should be found here,
    # even though registraion handles are not unique



    white = registrations.select { |reg| reg.handle == game.white_player_name }
    black = registrations.select { |reg| reg.handle == game.black_player_name }

    # Registration.find_by_handle(game.white_player_name)
    # black = Registration.find_by_handle(game.black_player_name)

    reg_match_hash = Hash.new

    reg_match_hash = {
      "white_player_name" => white[0].handle,
      "black_player_name" => black[0].handle,
      "white_player_id" => white[0].id,
      "black_player_id" => black[0].id,
      "game_digest" => game.game_digest,
      "winner_id" => game.winner_id,
      "winner_name" => game.winner_name,
      "division_id" => division.id,
      "match_id" => game.id
    }

    reg_match = RegistrationMatch.create(reg_match_hash)

  end



  def process_comments game, game_comments


    game_comments.each do |node, line|
      next if line.is_a? String
      line.each do |key, value|
        node_number = node.to_s.scan(/\d/).pop.to_i
        line_number = line.to_s.scan(/\d/).pop.to_i
        value = value.merge(:node_number => node_number, :line_number => line_number)

        # binding.pry if game.white_player_name.handle == "ChemBoy613" and node == :node_75
        value[:comment].force_encoding("UTF-8")
        comment = game.comments.build(value)
        comment.save
      end
    end

  end

end

