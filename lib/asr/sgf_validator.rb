module ASR

  class SGFValidator

    def initialize(args)
      @handle = args[:handle]
      @ignore_case = args[:ignore_case] || false
    end

    def handle
      @ignore_case ? @handle.downcase : @handle
    end

    def validate(sgf_data)
      @data = sgf_data.data

      valid = true
      checks = %W(player_presence result is_player_in_game registrations)
      checks.each { |check| valid &&= self.send("check_" + check, data) }
      valid
    end

    def self.filter_invalid(sgf_data_list, handle, ignore_case = false)
      validator = ASR::SGFValidator.new handle: handle, ignore_case: ignore_case
      sgf_data_list.select { |sgf_data| validator.validate(sgf_data) }
    end

    private

      def handle_clause
        @ignore_case ? 'LOWER(accounts.handle) = LOWER(?)' : 'accounts.handle = ?'
      end

      def registrations
        @registrations ||= Registration.where(handle_clause, handle).includes(:account)
      end

      def data
        @data
      end

      def white_player_handle
        w_handle = data[:white_player]
        @ignore_case ? w_handle.try(:downcase) : w_handle
      end

      def black_player_handle
        b_handle = data[:black_player]
        @ignore_case ? b_handle.try(:downcase) : b_handle
      end

      def is_white_player
        handle == white_player_handle
      end

      def is_black_player
        handle == black_player_handle
      end

      def check_player_presence(data)
        !black_player_handle.nil? && !white_player_handle.nil?
      end

      def check_result(data)
        !data[:result].nil?
      end

      def check_is_player_in_game(data)
        is_white_player || is_black_player
      end

      def check_registrations(data)
        valid = false
        registrations.reject { |r| r.division_id.nil? }.each do |reg|
          opp_handle = is_white_player ? black_player_handle : white_player_handle
          valid ||= Registration.
                        where("#{handle_clause} AND division_id = ?", opp_handle, reg.division_id).
                        joins(:account).
                        any?
        end
        valid
      end
  end
end