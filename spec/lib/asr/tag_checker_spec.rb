require 'spec_helper'

describe ASR::TagChecker do

  subject(:tag_checker) { ASR::TagChecker.new()}


  it "should fail if the node limit is exceeded" do
    match_tags = []
    match_tags << match_tag1 = FactoryGirl.build(:match_tag)
    match_tags << match_tag2 = FactoryGirl.build(:match_tag)

    tag_checker.tagged?(match_tags, 10).should be_true
  end

end