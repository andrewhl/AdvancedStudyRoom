require 'spec_helper'
require 'extractor'
require 'pry'


describe Extractor do
  subject(:archive) {
    Extractor.new source_path: "./spec/support/kabradarf-2012-9.zip",
                  target_path: "./temp/",
                  handle: "kabradarf"
  }

  context "initialization" do
    it { should be_true }
    it { should be_an_instance_of(Extractor) }
    it { should respond_to :extract_games }

  end

  describe "extraction" do

    before(:each) do
      archive.extract_games
    end

    it "should extract the games" do
      (Dir.entries(archive.target) - %w{ . .. }).empty?.should be_false
    end

  end

  describe "deletion" do

    it "should delete games" do
      archive.delete_temp_game_files
      (Dir.entries('./temp/') - %w{ . .. }).empty?.should be_true
    end

  end

  # describe "validate individual games" do



  #   # it "should receive an sgf file" do
  #   #   archive.extract_games(sgf_file, handle).should be_an_instance_of(String)
  #   # end

  #   # it "should open the sgf file" do
  #   #   pending
  #   # end

  #   # it "should return true if it has a valid tag" do
  #   #   # binding.pry
  #   #   archive.download_game(sgf_file).should be_true
  #   # end


  # end
end