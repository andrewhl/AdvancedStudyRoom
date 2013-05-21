module ASR
  class MatchFinder

    include Enumerable

    attr_accessor :from, :to
    attr_reader :matches

    def initialize(args = nil)
      if args.nil? || args == :current_month
        @from = Time.now.beginning_of_month
        @to = Time.now.end_of_month
      else
        @from, @to = args[:from], args[:to]
        @matches = args[:matches]
      end
      @matches ||= matches
    end

    def <<(matches)
      @matches << matches
    end

    def each(&block)
      @matches.each(&block)
    end

    def matches
      # these are date strings, not times
      start_date = @from.strftime("%Y-%m-%d")
      end_date  = @to.strftime("%Y-%m-%d")
      Match.where("completed_at <= ? AND completed_at >= ?", end_date, start_date).
            order(:completed_at, :created_at)
    end

    def by_same_opponent(*players)
      # Assume you got registration ids
      player_ids = players   # Defaults to assume you passed an integer, meaning an ID
      if players.first.is_a?(String) # If you pass a string, then it should be a handle
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
        MatchFinder.new(matches: matches)
      end

  end
end

