module ASR

  class PointManager

    def initialize(args)
      @finder = args[:finder]
   end

    def points_for(matches)
      matches.collect do |m|
        position = match_position(m)
        next if position.nil?
        get_points(m, position)
      end.flatten.compact
    end

    private

      def get_points(match, position)
        point_count = count(match, position)
        return [] if point_count.nil?

        winner_point = build_point(point_count[:winner], match.winner, match)
        loser_point = build_point(point_count[:loser], match.loser, match)

        [winner_point, loser_point]
      end

      def build_point(count, registration, match)
        Point.new(
          count: count,
          awarded_at: match.completed_at,
          account: registration.account,
          registration: registration,
          match: match,
          event: match.event,
          event_type: match.event.event_type,
          event_desc: nil)
      end

      def count(match, position)
        pc = ASR::PointCalculator.new(ruleset(match))
        pc.calculate(match, position)
      end

      def ruleset(match)
        match.event.point_ruleset.attributes.symbolize_keys
      end

      def match_position(match)
        matches = @finder.by_same_result(winner_id: match.winner_id, loser_id: match.loser_id).tagged.valid
        matches.find_index { |m| m.id == match.id }
      end

  end
end