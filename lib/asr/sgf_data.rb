require 'sgf'

module ASR

  class SGFData

    attr_reader :data, :game

    def initialize(args)
      @filepath = args[:file_path]
      @game_info = {}
      @comments = {}

      @game = parse_game
      clean_data
    end

    def self.valid?
      return @valid
    end

    def method_missing(method_name)
      data[method_name.to_sym]
    end

    private

      def parse_game
        parser = SGF::Parser.new
        tree = parser.parse(@filepath)
        game = tree.games.first
      end

      def clean_data
        preparer = ASR::SGFPreparer.new @game
        @data = preparer.data
      end

  end

end