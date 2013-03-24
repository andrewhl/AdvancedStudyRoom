['net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils', 'digest/md5'].each { |x| require x }

module ASR

  class SGFData

    def initialize(args)
      @filepath = args[:file_path]
      @parser = SGF::Parser.new
      @game_info = {}

      get_file_contents
    end

    def game_type
      @game_info["GM"].to_i
    end

    def file_format
      @game_info["FF"].to_i
    end

    def encode_type
      @game_info["CA"]
    end

    def application
      @game_info["AP"]
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
        tree = @parser.parse(@filepath)
        game = tree.games.first
        @game_info = game.current_node.properties
      end

  end

end