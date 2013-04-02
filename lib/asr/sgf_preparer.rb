module ASR

  class SGFPreparer

    attr_accessor :game_type, :data

    def initialize(args)
      @sgf = args[:sgf]
    end

    def data
      {
        black_player: black_player,
        white_player: white_player,
        board_size: board_size,
        komi: komi,
        time_limit: time_limit,
        overtime: overtime,
        handicap: handicap,
        result: result
      }
    end

    def black_player
      @sgf.data[:black_player].downcase
    end

    def white_player
      @sgf.data[:white_player].downcase
    end

    def board_size
      @sgf.data[:board_size].to_i
    end

    def komi
      @sgf.data[:komi].to_f
    end

    def time_limit
      @sgf.data[:time_limit].to_i
    end

    def handicap
      @sgf.data[:handicap].to_i
    end

    def overtime
      if @sgf.overtime.nil?
        { ot_type: "None", ot_main: 0, ot_stones: 0 }
      else
        overtime = @sgf.overtime.split(" ")

        # Overtime main time/periods and number of stones (e.g., 10 periods, 15 stones, or 300 seconds, 25 stones)
        ot_settings = overtime[0].split("x")

        {
          ot_type: overtime[1], # Type of overtime, e.g. byo-yomi, Canadian
          ot_main: ot_settings[0], # Always an integer; whether it represents seconds or number of periods is determined by ot_type
          ot_stones: ot_settings[1] # Always just the number of stones per period/seconds
        }
      end
    end

    def result
      result = @sgf.data[:result].split("+")
      {
        winner: result[0],
        win_info: result[1]
      }
    end

  end

end