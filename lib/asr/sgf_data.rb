require 'sgf'

module ASR

  class SGFData

    attr_reader :data, :game

    def initialize(args)
      @filepath = args[:file_path]
    end

    def game
      @game ||= parse_game
    end

    def data
      @data ||= prepare_data
    end

    def method_missing(method_name, args, &block)
      data.send(method_name.to_sym, *args, &block)
    end

    private

      def parse_game
        parser = SGF::Parser.new
        tree = parser.parse(@filepath)
        tree.games.first
      end

      def prepare_data
        preparer = ASR::SGFPreparer.new game
        preparer.data
      end

  end

end