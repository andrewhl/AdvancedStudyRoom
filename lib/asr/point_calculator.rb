module ASR

  class PointCalculator

    def initialize args
      @points_per_win             = args[:points_per_win] || 0
      @point_decay                = args[:point_decay] || 0
      @min_points_per_match       = args[:min_points_per_match] || 0
      @points_per_loss            = args[:points_per_loss] || 0
      @max_matches_per_opponent   = args[:max_matches_per_opponent] || 0
    end

    def calculate(match, position)
      return nil unless pointable?(match, position)
      {winner: winner_points(match, position), loser: loser_points(match, position)}
    end

    private

      def pointable?(match, position)
        position < @max_matches_per_opponent
      end

      def winner_points(match, position)
        @min_points_per_match + @points_per_win * (@point_decay ** position)
      end

      def loser_points(match, position)
        @min_points_per_match + @points_per_loss * (@point_decay ** position)
      end

  end

end