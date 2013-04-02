['sgf_preparer', 'net/http', 'pry', 'open-uri', 'zip/zip', 'sgf', 'fileutils', 'digest/md5'].each { |x| require x }

module ASR

  class SGFData

    attr_reader :valid_game, :data, :game_info

    NAME_TO_SGF_CODE = {
      rules: "RU",
      board_size: "SZ",
      komi: "KM",
      time_limit: "TM",
      overtime: "OT",
      black_player: "PB",
      white_player: "WR",
      black_rank: "BR",
      date_of_game: "DT",
      result: "RE",
      handicap: "HA"
    }

    def initialize(args)
      @filepath = args[:file_path]
      @game_info ||= {}
      @valid_game = true

      get_file_contents
    end

    def self.valid_game
      return @valid_game
    end

    def data
      @data ||=
      {
        rules: rules,
        board_size: board_size,
        komi: komi,
        time_limit: time_limit,
        overtime: overtime,
        black_player: black_player,
        white_player: white_player,
        white_rank: white_rank,
        black_rank: black_rank,
        handicap: handicap,
        date_of_game: date_of_game,
        result: result
      }
    end

    def method_missing method
      @game_info[NAME_TO_SGF_CODE[method]]
    end

    def clean_data
      preparer = ASR::SGFPreparer.new sgf: self
      data.merge(preparer.data)
    end

    def clean_data!
      preparer = ASR::SGFPreparer.new sgf: self
      @data = data.merge(preparer.data)
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