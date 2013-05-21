require 'spec_helper'

describe ASR::RuleMerger do

  let!(:division) { FactoryGirl.create(:division) }
  let!(:division_ruleset) { division.ruleset }
  let!(:tier_ruleset) { division.tier.ruleset }
  let!(:event_ruleset) { division.tier.event.ruleset }

  it "should overwrite nil values with parent values" do
    division_ruleset.j_ot_min_periods = nil
    tier_ruleset.j_ot_min_periods = 5
    rule_merger = ASR::RuleMerger.new(event_ruleset, tier_ruleset, division_ruleset)
    rule_merger.rules[:j_ot_min_periods].should == 5
  end

  it "should overwrite parent values with child values" do
    division_ruleset.j_ot_min_periods = 1
    # binding.pry

    rule_merger = ASR::RuleMerger.new(event_ruleset, tier_ruleset, division_ruleset)
    rule_merger.rules[:j_ot_min_periods].should == 1
  end

  it "should take tier values if different from event values" do
    tier_ruleset.j_ot_min_periods = 3
    division_ruleset.j_ot_min_periods = nil

    rule_merger = ASR::RuleMerger.new(event_ruleset, tier_ruleset, division_ruleset)
    rule_merger.rules[:j_ot_min_periods].should == 3
  end

end