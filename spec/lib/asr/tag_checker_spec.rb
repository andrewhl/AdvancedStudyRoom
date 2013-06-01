require 'spec_helper'

describe ASR::TagChecker do

  subject(:tag_checker) {
    event_tags = [FactoryGirl.build(:event_tag, phrase: '#asr')]
    ASR::TagChecker.new(event_tags)
  }


  it "should fail if the node limit is exceeded" do
    match_tags = FactoryGirl.build_list(:match_tag, 2)
    match_tags << FactoryGirl.build(:match_tag, phrase: '#asr', node: 15)
    tag_checker.tagged?(match_tags, 10).should be_false
  end

end