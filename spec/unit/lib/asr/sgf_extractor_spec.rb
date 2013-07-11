require 'spec_helper'

describe ASR::SGFExtractor do

  subject(:extractor) {
    ASR::SGFExtractor.new(
      source_path:  "./spec/support/kabradarf-2012-9.zip",
      target_path:  "./tmp/#{Time.now.to_i}",
      handle:       "kabradarf")
  }

  describe "extraction" do
    it "should extract the games" do
      extractor.extract_games
      (Dir.entries(extractor.target_path) - %w{ . .. }).empty?.should be_false
      FileUtils.remove_dir(extractor.target_path) rescue ''
    end
  end

end