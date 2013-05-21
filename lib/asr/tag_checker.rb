module ASR

  class TagChecker

    def initialize(event)
      @event = event

      @event_tags = get_event_tags
    end

    def tagged?(match)
      match_tags = get_match_tags(match)
      match_tags.select { |tag| @event_tags.include?(tag) }.any?
    end

    private

      def get_event_tags
        @event.tags.collect { |tag| tag.phrase.downcase }
      end

      def get_match_tags(match)
        match.tags.split(",").collect { |m| m.strip.downcase }
      end

  end
end