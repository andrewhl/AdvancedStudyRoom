require 'spec_helper'

describe ASR::RuleMerger do

  let(:child_ruleset) { FactoryGirl.build(:ruleset) }
  let(:parent_ruleset) { FactoryGirl.build(:ruleset) }

  it "should overwrite nil values with parent values" do
    child_ruleset.j_ot_min_periods = nil
    parent_ruleset.j_ot_min_periods = 5
    rule_merger = ASR::RuleMerger.new(parent_ruleset, child_ruleset)
    rule_merger.rules[:j_ot_min_periods].should == 5
  end

  it "should overwrite parent values with child values" do
    child_ruleset.j_ot_min_periods = 1
    parent_ruleset.j_ot_min_periods = 2
    rule_merger = ASR::RuleMerger.new(parent_ruleset, child_ruleset)
    rule_merger.rules[:j_ot_min_periods].should == 1
  end

  it "should take tier values if different from event values" do
    parent_ruleset.j_ot_min_periods = 3
    child_ruleset.j_ot_min_periods = nil
    rule_merger = ASR::RuleMerger.new(parent_ruleset, child_ruleset)
    rule_merger.rules[:j_ot_min_periods].should == 3
  end

end