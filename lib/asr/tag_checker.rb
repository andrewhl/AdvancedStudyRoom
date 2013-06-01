module ASR

  class TagChecker

    def initialize(event_tags)
      @tag_phrases = format_tags(event_tags)
    end

    def tagged?(match_tags, node_limit)
      match_tags.select do |tag|
        @tag_phrases.include?(format_phrase(tag.phrase)) &&
        tag.node <= node_limit
      end.any?
    end

    private

      def format_tags(tags)
        tags.collect do |tag|
          format_phrase(tag.phrase)
        end
      end

      def format_phrase(phrase)
        phrase.scan(/\w+/).first.downcase.strip
      end

  end
end