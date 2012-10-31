['net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils'].each { |x| require x }

class Validator

  def validate_games filepath

    Zip::ZipFile.open(filepath) do |zip_file|
      zip_file.each do |f|
        f_path = File.join("temp", File.basename(f.to_s))
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exists?(f_path)

        event = EventType.new
        event.validate_game(f_path.to_s)
        # validate_game(f_path.to_s)
        # collect_game_data(f_path.to_s)
        convert_sgf_to_game(f_path.to_s)

        FileUtils.remove_entry(f_path)
      end
    end
  end

  def convert_sgf_to_game file
    parser = SGF::Parser.new
    tree = parser.parse(file)
    game = tree.games.first

    # Only converts games that contain the ASR tag in the first 30 moves

    ginfo = game.current_node.properties

    if (has_valid_tag game)
      # date_time = game.date
      ruleset = game.rules
      board_size = ginfo["SZ"]
      # komi = game.komi.to_f
      black_player = game.black_player
      white_player = game.white_player

      # Add later: black_player_id = Account.where("handle=? and server_id=?", black_player, 1)

      # handicap = ginfo["HA"]
      result = ginfo["RE"].split("+")

      main_time = ginfo["TM"]
      overtime = ginfo["OT"].split(" ")

      # Type of overtime, e.g. byo-yomi, Canadian
      ot_type = overtime[1]

      # Overtime main time/periods and number of stones (e.g., 10 periods, 15 stones, or 300 seconds, 25 stones)
      ot_settings = overtime[0].split("x")

      # Always an integer; whether it represents seconds or number of periods is determined by ot_type
      ot_main = ot_settings[0]

      # Always just the number of stones per period/seconds
      ot_stones = ot_settings[1]

      winner = result[0]
      win_info = result[1]
      puts "valid game"

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
        "black_player_name" => black_player,
        "white_player_name" => white_player,
        "handicap" => ginfo["HA"]
      }

      match = Match.new(game_hash)
      match.save
    end

  end

  def has_valid_tag game
    tag_phrase = /asr league/i

    # Check that the first node has the tag

    valid_tag = false
    i = 0
    node_limit = 30 # Move limit in which the tag must appear

    game.each do |node|
      # binding.pry
      unless node.properties["C"].nil?
        valid_tag = true if !node.C.scan(tag_phrase).empty?
      end
      i += 1
      return valid_tag if i > node_limit
    end

  end

  def collect_game_data file
    parser = SGF::Parser.new
    tree = parser.parse(file)
    game = tree.games.first


    asr_game = Match.new
  end

end

