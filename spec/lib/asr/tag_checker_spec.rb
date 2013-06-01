require 'spec_helper'

describe ASR::TagChecker do

  subject(:tag_checker) { ASR::TagChecker.new()}


  it "should fail if the node limit is exceeded" do
    match = FactoryGirl.build(:match)
    match.stub(:comments).returns(comment)

    tag_checker.tagged?(match, 10).should be_true
  end

end