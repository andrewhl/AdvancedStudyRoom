module ASR

  class PointCalculator

    def initialize args
      @points_per_win             = args[:points_per_win] || 0
      @win_decay                  = args[:win_decay] || 0
      @loss_decay                 = args[:loss_decay] || 0
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
        @min_points_per_match + @points_per_win * calculate_decay(@win_decay, position)
      end

      def loser_points(match, position)
        @min_points_per_match + @points_per_loss * calculate_decay(@loss_decay, position)
      end

      def calculate_decay(decay, position)
        return 1 if decay.to_f.round(2) <= 0 # 1 is the same as no decay
        (1 - decay) ** position
      end

  end

end