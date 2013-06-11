module ASR
  class MatchFinder

    include Enumerable

    attr_accessor :from, :to, :event
    attr_reader :matches

    def initialize(args = nil)
      @from     = args[:from] || Time.now.beginning_of_month
      @to       = args[:to] || Time.now.end_of_month
      @matches  = args[:matches]
      @event    ||= args[:event]
      @matches  ||= matches
    end

    def <<(matches)
      @matches << matches
    end

    def each(&block)
      @matches.each(&block)
    end

    def matches
      Match.
        select('matches.*').
        joins(:black_player).
        where(
          "registrations.event_id = ? AND completed_at >= ? AND completed_at <= ?",
          event.id, @from.strftime("%Y-%m-%d"), @to.strftime("%Y-%m-%d")).
        order(:completed_at, :created_at)
    end

    def by_same_opponent(*players)
      player_ids = players.first.to_i > 0 ?
                      players :
                      players.collect { |handle| Account.where(handle: handle).first.try(:id) }
      matches = @matches.where('black_player_id IN (?) AND white_player_id IN (?)', player_ids, player_ids)
      build(matches)
    end

    def by_same_result(args)
      matches = @matches.where('winner_id = ? AND loser_id = ?', args[:winner_id], args[:loser_id])
      build(matches)
    end

    def by_division(division)
      matches = @matches.where("matches.division_id = ?", division.id)
      build(matches)
    end

    def by_registration(registration)
      matches = @matches.where("black_player_id = ? OR white_player_id = ?", registration.id, registration.id)
      build(matches)
    end

    def tagged
      matches = @matches.where("matches.tagged = ?", true)
      build(matches)
    end

    def valid
      matches = @matches.where("matches.valid_match = ?", true)
      build(matches)
    end

    def with_points
      matches = @matches.where("matches.has_points = ?", true)
      build(matches)
    end

    def without_points
      matches = @matches.where("matches.has_points = ?", false)
      build(matches)
    end

    def by_ot_type(ot_type)
      matches = @matches.where("matches.ot_type = ?", ot_type)
      build(matches)
    end

    private

      def build(matches)
        MatchFinder.new(
          from: from,
          to: to,
          event: event,
          matches: matches)
      end

  end
end

