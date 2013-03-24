require 'spec_helper'
require 'sgf_preparer'
require 'sgf_data'
require 'pry'

describe ASR::SGFPreparer do

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

  describe "reading files" do

    let!(:sgf_data_object) { ASR::SGFData.new file_path: "./spec/DrGoPlayer-kabradarf.sgf" }
    subject(:prepared_sgf) {
        # binding.pry
      ASR::SGFPreparer.new sgf: sgf_data_object
    }

    it "should display board size" do
      prepared_sgf.data[:board_size].should == 19
    end

    it "should display komi" do
      prepared_sgf.data[:komi].should == 6.50
    end

    it "should display time limit" do
      prepared_sgf.data[:time_limit].should == 1500
    end

    it "should display overtime" do
    end

    it "should display black player name" do
    end

    it "should display white player name" do
    end

    it "should display white player rank" do
    end

    it "should display black player rank" do
      pending
    end

    it "should display date of game" do
    end

    it "should display game result" do
    end

  end

end