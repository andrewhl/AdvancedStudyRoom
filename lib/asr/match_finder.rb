module ASR
  class MatchFinder

    include Enumerable

    attr_accessor :from, :to, :event
    attr_reader :matches

    def initialize(args = nil)
      if args.nil? || args == :current_month
        @from = Time.now.beginning_of_month
        @to = Time.now.end_of_month
      else
        @from, @to = args[:from], args[:to]
        @matches = args[:matches]
      end
      @event ||= args[:event]
      @matches ||= matches
    end

    def <<(matches)
      @matches << matches
    end

    def each(&block)
      @matches.each(&block)
    end

    def matches
      Match.
        joins(:black_player)
        where(
          "registrations.event_id = ? AND completed_at >= ? AND completed_at <= ?",
          event.id, @from.strftime("%Y-%m-%d"), @to.strftime("%Y-%m-%d")).
        order(:completed_at, :created_at)
    end

    def by_same_opponent(*players)
      # Assume you got registration ids
      player_ids = players   # Defaults to assume you passed an integer, meaning an ID
      if players.first.is_a?(String) # If you pass a string, then it must be a handle
        player_ids = players.collect { |handle| Account.where(handle: handle).first.try(:id) }
      end

      matches = @matches.where('black_player_id IN (?) AND white_player_id IN (?)', player_ids, player_ids)
      build(matches)
    end

    def by_division(division)
      matches = @matches.where("division_id = ?", division.id)
      build(matches)
    end

    def by_registration(registration)
      matches = @matches.where("black_player_id = ? OR white_player_id = ?", registration.id, registration.id)
      build(matches)
    end

    def tagged
      matches = @matches.where("tagged = ?", true)
      build(matches)
    end

    def valid
      matches = @matches.where("valid_match = ?", true)
      build(matches)
    end

    def with_points
      matches = @matches.where("has_points = ?", true)
      build(matches)
    end

    def without_points
      matches = @matches.where("has_points = ?", false)
      build(matches)
    end

    def by_ot_type(ot_type)
      matches = @matches.where("ot_type = ?", ot_type)
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

