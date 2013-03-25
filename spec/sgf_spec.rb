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

    it "should display nil if no black player rank" do
      sgf_data.black_rank.should == nil
    end

    it "should display date of game" do
      sgf_data.date_of_game.should == "2012-09-01"
    end

    it "should display game result" do
      sgf_data.result.should == "B+Resign"
    end

    it "should display nil for empty values" do
      sgf_data.black_rank.should == nil
    end


  end

  describe "data preparation" do

    it "should return a hash" do
      sgf_data.clean_data.should be_an_instance_of(Hash)
    end

    it "should list the winner" do
      sgf_data.clean_data[:result][:winner].should == "B"
    end

    it "should list the win info" do
      sgf_data.clean_data[:result][:win_info].should == "Resign"
    end

    it "should lowercase the white player name" do
      sgf_data.clean_data[:white_player].should == "drgoplayer"
    end



  end


end