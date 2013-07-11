require 'spec_helper'

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

  describe "when preparing SGFData" do

    let(:sgf_data) { FactoryGirl.build(:sgf_data) }
    subject(:prepared_sgf) { ASR::SGFPreparer.new sgf_data.game }

    it "should convert board size to integer" do
      prepared_sgf.game_info["SZ"] = "19"
      prepared_sgf.data[:board_size].should == 19
    end

    it "should convert komi to float" do
      prepared_sgf.game_info["KM"] = "6.50"
      prepared_sgf.data[:komi].should == 6.50
    end

    it "should convert time to integer" do
      prepared_sgf.game_info["TM"] = "1500"
      prepared_sgf.data[:time_limit].should == 1500
    end

    it "should generate the filename" do
      prepared_sgf.data[:filename].should == "DrGoPlayer-kabradarf.sgf"
    end

    context "overtime" do

      it "should parse out Japanese overtime type" do
        prepared_sgf.game_info["OT"] = "5x30 byo-yomi"
        prepared_sgf.data[:overtime][:type].should == "byo-yomi"
      end

      it "should parse out Japanese overtime main setting" do
        prepared_sgf.game_info["OT"] = "5x30 byo-yomi"
        prepared_sgf.data[:overtime][:main].should == "5"
      end

      it "should parse out Japanese overtime stones" do
        prepared_sgf.game_info["OT"] = "5x30 byo-yomi"
        prepared_sgf.data[:overtime][:stones_periods].should == "30"
      end

      it "should parse out Canadian overtime type" do
        prepared_sgf.game_info["OT"] = "25x300 Canadian"
        prepared_sgf.data[:overtime][:type].should == "Canadian"
      end

      it "should parse out Canadian overtime main setting" do
        prepared_sgf.game_info["OT"] = "25x300 Canadian"
        prepared_sgf.data[:overtime][:main].should == "25"
      end

      it "should parse out Canadian overtime stones" do
        prepared_sgf.game_info["OT"] = "25x300 Canadian"
        prepared_sgf.data[:overtime][:stones_periods].should == "300"
      end

    end


    context "players" do

      it "should display handicap as integer" do
        prepared_sgf.game_info["HA"] = "0"
        prepared_sgf.data[:handicap].should == 0
      end

      it "should display white player rank" do
        prepared_sgf.game_info["WR"] = "3k"
        prepared_sgf.data[:white_rank].should == -2
      end

      it "should display black player rank" do
        prepared_sgf.game_info["BR"] = "2d"
        prepared_sgf.data[:black_rank].should == 2
      end

      it "should handle nil ranks" do
        prepared_sgf.game_info["BR"] = nil
        prepared_sgf.data[:black_rank].should == -31
      end

    end

    context "game result by resignation" do

      before(:each) do
        prepared_sgf.game_info["RE"] = "B+Resign"
      end

      it "should display game winner" do
        prepared_sgf.data[:result][:winner].should == "B"
      end

      it "should display resignation result" do
        prepared_sgf.data[:result][:win_info].should == "Resign"
      end

      it "should identify resignation win type" do
        prepared_sgf.data[:result][:win_type].should == :resignation
      end

    end

    context "game result by points" do

      before(:each) do
        prepared_sgf.game_info["RE"] = "W+42.50"
      end

      it "should display game winner" do
        prepared_sgf.data[:result][:winner].should == "W"
      end

      it "should display resignation result" do
        prepared_sgf.data[:result][:win_info].should == "42.50"
      end

      it "should identify resignation win type" do
        prepared_sgf.data[:result][:win_type].should == :points
      end

    end

    context "game result by time" do

      before(:each) do
        prepared_sgf.game_info["RE"] = "W+Time"
      end

      it "should display game winner" do
        prepared_sgf.data[:result][:winner].should == "W"
      end

      it "should display resignation result" do
        prepared_sgf.data[:result][:win_info].should == "Time"
      end

      it "should identify resignation win type" do
        prepared_sgf.data[:result][:win_type].should == :time
      end

    end


    context "game result by forfeit" do

      before(:each) do
        prepared_sgf.game_info["RE"] = "W+Forfeit"
      end

      it "should display game winner" do
        prepared_sgf.data[:result][:winner].should == "W"
      end

      it "should display resignation result" do
        prepared_sgf.data[:result][:win_info].should == "Forfeit"
      end

      it "should identify resignation win type" do
        prepared_sgf.data[:result][:win_type].should == :forfeit
      end

    end


    context "game result by unfinished" do

      before(:each) do
        prepared_sgf.game_info["RE"] = nil
      end

      it "should display game winner" do
        prepared_sgf.data[:result][:winner].should == nil
      end

      it "should display resignation result" do
        prepared_sgf.data[:result][:win_info].should == ""
      end

      it "should identify resignation win type" do
        prepared_sgf.data[:result][:win_type].should == :unfinished
      end

    end

    context "game type" do
      before(:each) do
        prepared_sgf.game_info["EV"] = "Ranked"
      end

      it "should display the game type" do
        prepared_sgf.data[:match_type].should == "Ranked"
      end
    end

    context 'comments' do

      it "should have comments" do
        prepared_sgf.data[:comments][0].should == {
          node_number: 0, line_number: 1,
          handle: "DrGoPlayer", rank: "3k", comment: "hi", date: "2012-09-01" }
      end

      it "should parse the node lines" do
        prepared_sgf.data[:comments].size.should == 12
      end

      context 'each comment' do
        subject(:comment) { prepared_sgf.data[:comments][0] }

        it "should parse the player handle" do
          comment[:handle] = 'DrGoPlayer'
        end

        it "should parse the player rank" do
          comment[:rank] = '3k'
        end

        it "should parse the player comment" do
          comment[:comment] = 'hi'
        end
      end
    end

  end

end