require 'spec_helper'
require 'sgf_data'
require 'pry'

describe ASR::SGFData do

# Expected hash:
# {"GM"=>"1",
#  "FF"=>"4",
#  "CA"=>"UTF-8",
#  "AP"=>"CGoban:3",
#  "ST"=>"2",
#  "RU"=>"Japanese",
#  "SZ"=>"19",
#  "KM"=>"6.50",
#  "TM"=>"1500",
#  "OT"=>"5x30 byo-yomi",
#  "PW"=>"DrGoPlayer",
#  "PB"=>"kabradarf",
#  "WR"=>"3k",
#  "DT"=>"2012-09-01",
#  "PC"=>"The KGS Go Server at http://www.gokgs.com/",
#  "C"=>
#   "DrGoPlayer [3k]: hi\nkabradarf [-]: hi\nkabradarf [-]: gg\nDrGoPlayer [3k]: have fun!\nkabradarf [-]: asr league\n",
#  "RE"=>"B+Resign"}

  subject(:sgf_data) {
    ASR::SGFData.new file_path: "./spec/DrGoPlayer-kabradarf.sgf"
  }

  it { should be_true }

  describe "reading files" do

    it "should read an sgf file and return a hash" do
      sgf_data.send(:get_file_contents).should be_an_instance_of(Hash)
    end

    it "should display game type as integer" do
      sgf_data.game_type.should == 1
    end

    it "should display file format as integer" do
      sgf_data.file_format.should == 4
    end

    it "should display encode type" do
      sgf_data.encode_type.should == "UTF-8"
    end

    it "should display application" do
      sgf_data.application.should == "CGoban:3"
    end

    it "should display ruleset" do
      sgf_data.rules.should == "Japanese"
    end

    it "should display board size" do
      sgf_data.board_size == "19"
    end

    it "should display komi" do
      sgf_data.komi == "6.50"
    end

    it "should display time limit" do
      sgf_data.time_limit.should == "1500"
    end

    it "should display overtime" do
      sgf_data.overtime.should == "5x30 byo-yomi"
    end

    it "should display black player name" do
      sgf_data.black_player.should == "kabradarf"
    end

    it "should display white player name" do
      sgf_data.white_player.should == "DrGoPlayer"
    end

    it "should display white player rank" do
      sgf_data.white_rank.should == "3k"
    end

    it "should display black player rank" do
      pending
    end

    it "should display date of game" do
      sgf_data.date_of_game.should == "2012-09-01"
    end

    it "should display game result" do
      sgf_data.result.should == "B+Resign"
    end

  end

end