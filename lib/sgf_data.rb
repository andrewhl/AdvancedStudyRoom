['net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils', 'digest/md5'].each { |x| require x }

module ASR

  class SGFData

    attr_reader :valid_game, :data

    def initialize(args)
      @filepath = args[:file_path]
      @game_info = {}
      @valid_game = true

      get_file_contents
    end

    def data
      {
        rules: rules,
        board_size: board_size,
        komi: komi,
        time_limit: time_limit,
        overtime: overtime,
        black_player: black_player,
        white_player: white_player,
        white_rank: white_rank,
        black_rank: nil,
        date_of_game: date_of_game,
        result: result
      }
    end

    def clean_data
      preparer = ASR::SGFPreparer.new sgf: self
      data.merge(preparer.data)
    end

    def rules
      @game_info["RU"]
    end

    def board_size
      @game_info["SZ"]
    end

    def komi
      @game_info["KM"]
    end

    def time_limit
      @game_info["TM"]
    end

    def overtime
      @game_info["OT"]
    end

    def black_player
      @game_info["PB"]
    end

    def white_player
      @game_info["PW"]
    end

    def white_rank
      @game_info["WR"]
    end

    def black_rank
      # bug in parser, this method isn't implemented
      # TODO: Submit pull request for this to be implemented
      raise NotImplementedError
    end

    def date_of_game
      @game_info["DT"]
    end

    def result
      @game_info["RE"]
    end


    private

      def get_file_contents
        parser = SGF::Parser.new
        tree = parser.parse(@filepath)
        game = tree.games.first
        @game_info = game.current_node.properties
      end

  end

end