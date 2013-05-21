module ASR

  class SGFPreparer

    NAME_TO_SGF_CODE = {
      rules:        "RU",
      board_size:   "SZ",
      komi:         "KM",
      time_limit:   "TM",
      overtime:     "OT",
      black_player: "PB",
      white_player: "PW",
      white_rank:   "WR",
      black_rank:   "BR",
      date_of_game: "DT",
      handicap:     "HA",
      match_type:   "EV",
      result:       "RE"
    }

    attr_accessor :match_type, :data, :game, :game_info, :comments

    def initialize(game)
      @game = game
      @game_info = game.current_node.properties
    end

    def get(key)
      @game_info[NAME_TO_SGF_CODE[key]]
    end

    def data
      {
        rules:        get(:rules),
        board_size:   board_size,
        komi:         komi,
        time_limit:   time_limit,
        overtime:     overtime,
        black_player: black_player,
        white_player: white_player,
        white_rank:   white_rank,
        black_rank:   black_rank,
        date_of_game: get(:date_of_game),
        handicap:     handicap,
        match_type:    get(:match_type),
        result:       result,
        comments:     comments,
        tags:         tags,
        filename:     filename
      }
    end

    def tags
      @tags ||= parse_tags
    end

    def black_player
      get(:black_player).downcase
    end

    def white_player
      get(:white_player).downcase
    end

    def white_rank
      Utilities::rank_convert(get(:white_rank))
    end

    def black_rank
      Utilities::rank_convert(get(:black_rank))
    end

    def board_size
      get(:board_size).to_i
    end

    def komi
      get(:komi).to_f
    end

    def time_limit
      get(:time_limit).to_i
    end

    def handicap
      get(:handicap).to_i
    end

    def overtime
      return { type: "None", main: 0, stones_periods: 0 } if get(:overtime).nil?

      overtime = get(:overtime).split(" ")
      # Overtime main time/periods and number of stones (e.g., 10 periods, 15 stones, or 300 seconds, 25 stones)
      ot_settings = overtime[0].split(/x|\//)

      {
        type: overtime[1], # Type of overtime, e.g. byo-yomi, Canadian
        main: ot_settings[0], # Always an integer; whether it represents seconds or number of periods is determined by ot_type
        stones_periods: ot_settings[1] # Always just the number of stones per period/seconds
      }
    end

    def filename
      "#{get(:white_player)}-#{get(:black_player)}.sgf"
    end

    def result
      result = get(:result).to_s.split("+")
      win_info = result[1].to_s

      {
        winner: result[0],
        win_info: win_info,
        win_type: identify_win_type(win_info)
      }
    end

    def comments
      @comments ||= parse_comments
    end

    private

      def identify_win_type win_info
        case win_info
        when /resign/i
          :resignation
        when /\d+/i
          :points
        when /time/i
          :time
        when /forfeit/i
          :forfeit
        else
          :unfinished
        end
      end

      def parse_tags
        tags = []
        comments.each do |comment|
          tags << comment[:comment].to_s.scan(/(\#[^\s\,]+)/)
        end
        tags.flatten.join(",")
      end

      def parse_comments
        comments = []

        game.each_with_index do |node, node_index|
          next unless node.properties["C"]
          lines = node.properties["C"].split("\n")
          lines.each_with_index do |line, line_index|
            # Skip because last line in comment is the node number
            next if line.is_a? Fixnum

            handle = line.scan(/^[a-zA-Z0-9]+/).pop
            rank = line.scan(/\[([\d]+[d|k]|[\d]+[d|k]\?|\?|\-)\]/).flatten.pop
            comment = line.scan(/\:\s(.+)/).flatten.pop

            comments << {
              node_number: node_index,
              line_number: line_index + 1,
              handle: handle,
              rank: rank,
              comment: comment,
              date: game.date }
          end
        end

        comments
      end

  end

end