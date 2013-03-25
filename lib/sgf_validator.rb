module ASR
  class SGFValidator

    def initialize(args)
      @sgf = args[:sgf]
      @username = args[:username]
      @valid = true


    end

    def data
      {

      }
    end

    def check_player_presence
      @valid = (!@sgf.black_player.nil?) ? true : false
      @valid = (!@sgf.white_player.nil?) ? true : false
    end







  end
end