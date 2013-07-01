module ASR

  class SGFImporter

    <<-DOC
      This class handles the top-level instructions for downloading,
      parsing, and converting SGFs. The end result is a raw SGF file converted into
      an ActiveRecord Match object.
    DOC

    attr_reader :server
    attr_accessor :ignore_case

    def initialize(args)
      @server  = args[:server]
      @scraper = args[:scraper]
      @ignore_case = args[:ignore_case] || false
    end

    def import_matches(args)
      now = Time.now
      args = {
        handles: [],
        handle: nil,
        year: now.year,
        month: now.month }.merge(args)
      args[:handles] << args[:handle]

      import_month_matches(args[:handles], args[:month], args[:year])
    end

    private

      def import_month_matches(handles, month, year)
        imported_matches = handles.collect do |handle|
          sgf_files = scraper.scrape_games(handle: handle, month: month, year: year)
          return [] unless sgf_files

          valid_sgf_data = collect_valid_sgf_data(sgf_files, handle)
          build_matches(valid_sgf_data)
        end

        FileUtils.remove_dir(scraper.target_path) rescue nil
        imported_matches.flatten
      end

      def collect_valid_sgf_data(sgf_files, handle)
        validator = ASR::SGFValidator.new(handle: handle, ignore_case: ignore_case)
        sgf_files.collect do |entry|
          next unless File.exists?(entry)
          sgf_data = SGFData.new(file_path: entry)
          next unless validator.validate(sgf_data)
          sgf_data
        end.compact
      end

      def build_matches(sgf_data_list)
        sgf_data_list.collect do |sgf_data|
          w_player = Account.find_by_handle_and_server_id(sgf_data.white_player, server.id, ignore_case: ignore_case)
          b_player = Account.find_by_handle_and_server_id(sgf_data.black_player, server.id, ignore_case: ignore_case)

          next if w_player.nil? || b_player.nil? ||
                  Match.where(digest: match_digest(sgf_data)).exists?

          match = build_match(sgf_data: sgf_data)
          match.comments = build_match_comments(match, sgf_data)
          match.tags = build_match_tags(match, match.comments)
          match
        end.compact
      end

      def build_match(args)
        sgf_data      = args[:sgf_data]
        # white_player  = args[:white_player]
        # black_player  = args[:black_player]

        Match.new({
          # white_player:       white_player,
          # black_player:       black_player,
          # winner:             match_winner(args),
          # loser:              match_loser(args),
          digest:             match_digest(sgf_data),
          # division:           black_player.division,
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

      # def match_winner(args)
      #   args[:sgf_data].result[:winner] == "W" ?
      #     args[:white_player] : args[:black_player]
      # end

      # def match_loser(args)
      #   match_winner(args) == args[:white_player] ?
      #     args[:black_player] : args[:white_player]
      # end

      def scraper
        domain = /(?:https?\:\/\/)?([^\/]+)/.match(server.url)[1] rescue server.url
        domain = 'http://' + domain
        @scraper ||= scraper_class.new(domain: domain, target_path: scraper_target_path)
      end

      def scraper_class
        @scraper_class ||= server.scraper_class_name.constantize
      end

      def scraper_target_path
        @scraper_target_path ||= "./tmp/importer-#{Time.now.to_i}"
        @scraper.nil? ? @scraper_target_path : @scraper.target_path
      end
  end
end
