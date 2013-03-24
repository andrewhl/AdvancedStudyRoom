module ASR

  class SGFPreparer

    attr_accessor :game_type, :data

    def initialize(args)
      @sgf = args[:sgf]
    end

    def data
      {
        # game_type: game_type,
        # file_format: file_format]
        board_size: board_size,
        komi: komi,
        time_limit: time_limit
      }
    end

    # def game_type
    #   @sgf.data[:game_type].to_i
    # end

    # def file_format
    #   @sgf.data[:file_format].to_i
    # end

    def board_size
      @sgf.data[:board_size].to_i
    end

    def komi
      @sgf.data[:komi].to_f
    end

    def time_limit
      @sgf.data[:time_limit].to_i
    end

    def black_player
      @sgf.black_player

    end

  end

end