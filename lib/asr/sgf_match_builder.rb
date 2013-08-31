module ASR

  class SGFMatchBuilder

    def initialize(args={})
      opts = {ignore_case: true}.merge(args)
      @ignore_case = opts[:ignore_case]
      @server_id = args[:server_id]
      @event_id = args[:event_id]
    end

    def build_matches(sgf_data_collection)
      sgf_data_collection.collect do |sgf_data|
        build_match(sgf_data)
      end.compact
    end

    def build_match(sgf_data)
      raise "Match already exists" if match_exists?(sgf_data)
      raise "One or more accounts do not exist" if accounts_do_not_exist?(sgf_data)

      match = build_match_object(sgf_data)
      match.comments = build_match_comments(match, sgf_data)
      match.tags = build_match_tags(match, match.comments)
      match.attributes = get_match_event_related_attributes(match)
      match
    end

    def accounts_do_not_exist?(sgf_data)
      w_player = Account.find_by_handle_and_server_id(sgf_data.white_player, @server_id, ignore_case: @ignore_case)
      b_player = Account.find_by_handle_and_server_id(sgf_data.black_player, @server_id, ignore_case: @ignore_case)
      w_player.nil? || b_player.nil?
    end

    def match_exists?(sgf_data)
      Match.where(digest: match_digest(sgf_data)).exists?
    end

    def build_match_object(sgf_data)
      Match.new({
        digest:             match_digest(sgf_data),
        completed_at:       sgf_data.date_of_game,
        board_size:         sgf_data.board_size,
        komi:               sgf_data.komi,
        handicap:           sgf_data.handicap,
        match_type:         sgf_data.match_type,
        win_info:           sgf_data.result[:win_info],
        won_by:             sgf_data.result[:winner],
        main_time_control:  sgf_data.time_limit,
        ot_type:            sgf_data.overtime[:type],
        ot_stones_periods:  sgf_data.overtime[:stones_periods],
        ot_time_control:    sgf_data.overtime[:main],
        white_player_name:  sgf_data.white_player,
        black_player_name:  sgf_data.black_player,
        filename:           sgf_data.filename })
    end

    def build_match_comments(match, sgf_data)
      sgf_data.comments.collect do |comment|
        Comment.new(comment)
      end
    end

    def build_match_tags(match, match_comments)
      match_comments.collect do |comment|
        next unless match_tag = get_match_tag(comment.comment)
        MatchTag.new(
          handle:   comment.handle,
          node:     comment.node_number,
          phrase:   match_tag)
      end.compact
    end

    def get_match_tag(comment)
      comment.scan(/\#\w+/).first
    end

    def match_digest(sgf_data)
      Match.build_digest(
        white_handle:   sgf_data.white_player,
        black_handle:   sgf_data.black_player,
        completed_at:   sgf_data.date_of_game,
        win_info:       sgf_data.result[:win_info])
    end

    def get_match_event_related_attributes(match, options={})
      opts = { ignore_case: false }.merge(options)
      wp_name = match.white_player_name
      bp_name = match.black_player_name

      return nil unless event = find_event(@event_id)

      if opts[:ignore_case]
        wp_name = wp_name.downcase
        bp_name = bp_name.downcase
        query = 'event_id = ? AND LOWER(accounts.handle) = ?'
      else
        query = 'event_id = ? AND accounts.handle = ?'
      end

      w_reg = Registration.joins(:account).where(
        query, event.id, wp_name).first
      b_reg = Registration.joins(:account).where(
        query, event.id, bp_name).first

      {
        white_player: w_reg,
        black_player: b_reg,
        winner: match.won_by == "W" ? w_reg : b_reg,
        loser: match.won_by == "B" ? w_reg : b_reg,
        division_id: w_reg.division_id
      }
    end

    def find_event(event_id)
      if event_id
        Event.find_by_id(@event_id)
      else
        ASR::EventFinder.find(
          tags: match.tags.collect(&:phrase),
          handles: [bp_name, wp_name],
          date: match.completed_at)
      end
    end

  end

end

