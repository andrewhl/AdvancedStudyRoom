module ASR

  class SGFValidator

    attr_accessor :handle, :ignore_case, :sgf_data, :errors

    def initialize(args)
      @handle       = args[:handle]
      @ignore_case  = args[:ignore_case] || false
      @sgf_data     = args[:sgf_data]
    end

    def handle
      ignore_case ? @handle.downcase : @handle
    end

    def validate(sgf_data)
      self.sgf_data = sgf_data
      self.errors = []

      valid = true
      %w(player_presence result is_player_in_game registrations_parity).each do |check|
        check_value = self.send("check_" + check)
        valid &&= check_value
        self.errors << check unless check_value
      end

      valid
    end

    def valid?
      validate(sgf_data)
    end

    private

      def data
        @sgf_data.data
      end

      def white_player_handle
        w_handle = data[:white_player]
        ignore_case ? w_handle.try(:downcase) : w_handle
      end

      def black_player_handle
        b_handle = data[:black_player]
        ignore_case ? b_handle.try(:downcase) : b_handle
      end

      def check_player_presence
        !black_player_handle.nil? && !white_player_handle.nil?
      end

      def white_player?
        handle == white_player_handle
      end

      def black_player?
        handle == black_player_handle
      end

      def check_result
        !data[:result].nil? && data[:result][:win_info].to_s.strip != ''
      end

      def check_is_player_in_game
        white_player? || black_player?
      end

      def check_registrations_parity
        Event.check_registration_parity(
          ignore_case: ignore_case,
          handles: [white_player_handle, black_player_handle],
          date: data[:date_of_game])
      end
  end
end