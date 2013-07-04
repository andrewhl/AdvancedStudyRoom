module ASR
  class MatchValidator

    <<-DOC
      Then it will try to find non-nil values for each rule and check the
      match object's attributes against those rules.
    DOC

    attr_reader :rules

    def initialize(rules)
      @rules = rules
    end

    def errors
      @errors
    end

    def valid?(match)
      @errors = []

      @rules.each do |k, v|
        @errors << k if self.respond_to?(k) && !self.send(k, v, match)
      end

      @errors.empty?
    end

    private

      def main_time_max(main_time_max, match)
        match.match_detail.main_time_control <= main_time_max
      end

      def main_time_min(main_time_min, match)
        match.match_detail.main_time_control >= main_time_min
      end

      def overtime_required(overtime_bool, match)
        !overtime_bool || (!match.match_detail.ot_type.nil? &&
                           !match.match_detail.ot_stones_periods.nil? &&
                           !match.match_detail.ot_time_control.nil?)
      end

      def j_ot_allowed(jovertime_bool, match)
        jovertime_bool || !match.match_detail.byo_yomi?
      end

      def c_ot_allowed(covertime_bool, match)
        covertime_bool || !match.match_detail.canadian?
      end

      def j_ot_max_periods(j_ot_max_periods, match)
        !match.match_detail.byo_yomi? ||
        match.match_detail.ot_time_control <= j_ot_max_periods
      end

      def j_ot_min_periods(j_ot_min_periods, match)
        !match.match_detail.byo_yomi? ||
        match.match_detail.ot_time_control >= j_ot_min_periods
      end

      def j_ot_max_period_length(jot_max_period_len, match)
        !match.match_detail.byo_yomi? ||
        match.match_detail.ot_stones_periods <= jot_max_period_len
      end

      def j_ot_min_period_length(jot_min_period_len, match)
        !match.match_detail.byo_yomi? ||
        match.match_detail.ot_stones_periods >= jot_min_period_len
      end

      def c_ot_max_stones(c_ot_max_stones, match)
        !match.match_detail.canadian? ||
        match.match_detail.ot_stones_periods <= c_ot_max_stones
      end

      def c_ot_min_stones(c_ot_min_stones, match)
        !match.match_detail.canadian? ||
        match.match_detail.ot_stones_periods >= c_ot_min_stones
      end

      def c_ot_max_time(c_ot_max_time, match)
        !match.match_detail.canadian? ||
        match.match_detail.ot_time_control <= c_ot_max_time
      end

      def c_ot_min_time(c_ot_min_time, match)
        !match.match_detail.canadian? ||
        match.match_detail.ot_time_control >= c_ot_min_time
      end

      def max_komi(max_komi, match)
        match.match_detail.komi <= max_komi
      end

      def min_komi(min_komi, match)
        match.match_detail.komi >= min_komi
      end

      def max_handicap(max_handicap, match)
        match.match_detail.handicap <= max_handicap
      end

      def min_handicap(min_handicap, match)
        match.match_detail.handicap >= min_handicap
      end

      def handicap_required(handi_bool, match)
        !handi_bool || match.match_detail.handicap > 0
      end

  end
end