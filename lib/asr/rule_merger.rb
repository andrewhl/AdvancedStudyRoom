module ASR
  class RuleMerger

    <<-DOC
      Merges Ruleset objects into a single ruleset hash. Precedence given to last in sequence.
    DOC

    attr_reader :rules

    def initialize(*rulesets)
      @rules = get_ruleset_attrs(rulesets.compact)
    end

    private
      def get_ruleset_attrs(rulesets)
        ruleset_attributes = {}

        rulesets.each do |ruleset|
          ruleset_attributes.merge!(ruleset.rules.reject { |k, v| v.nil? })
        end

        ruleset_attributes
      end
  end
end