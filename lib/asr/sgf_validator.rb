module ASR

  class SGFValidator

    attr_accessor :handle, :ignore_case, :sgf_data

    def initialize(args)
      self.handle = args[:handle]
      self.ignore_case = args[:ignore_case] || false
      self.sgf_data = args[:sgf_data]
    end

    def handle
      ignore_case ? handle.downcase : handle
    end

    def valid?
      validate(@sgf_data)
    end

    def validate(sgf_data)
      @sgf_data = sgf_data

      valid = true
      checks = %W(player_presence result is_player_in_game registrations)
      checks.each { |check| valid &&= self.send("check_" + check) }
      valid
    end

    private

      def data
        @sgf_data.data
      end

      def handle_query_condition
        ignore_case ? 'LOWER(accounts.handle) = LOWER(?)' : 'accounts.handle = ?'
      end

      def registrations
        Registration.where(handle_query_condition, handle).includes(:account)
      end

      def white_player_handle
        w_handle = data[:white_player]
        ignore_case ? w_handle.try(:downcase) : w_handle
      end

      def black_player_handle
        b_handle = data[:black_player]
        ignore_case ? b_handle.try(:downcase) : b_handle
      end

      def white_player?
        handle == white_player_handle
      end

      def black_player?
        handle == black_player_handle
      end

      def check_player_presence
        !black_player_handle.nil? && !white_player_handle.nil?
      end

      def check_result
        !data[:result].nil? && data[:result][:win_info].to_s.strip != ''
      end

      def check_is_player_in_game
        white_player? || black_player?
      end

      def check_registrations
        valid = false
        registrations_in_a_group = registrations.reject { |r| r.registration_group_id.nil? }
        registrations_in_a_group.each do |reg|
          opp_handle = white_player? ? black_player_handle : white_player_handle
          valid ||= Registration.joins(:account).where(
                      "#{handle_query_condition} AND registration_group_id = ?",
                      opp_handle, reg.registration_group_id).any?
        end
        valid
      end
  end
end