require 'spec_helper'

require 'pry'

describe ASR::SGFValidator do

  describe "reading files" do

    let!(:sgf_data_object) { ASR::SGFData.new file_path: "./spec/DrGoPlayer-kabradarf.sgf" }
    subject(:sgf_validator) { ASR::SGFValidator.new }

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

    it "should display overtime type" do
      prepared_sgf.data[:overtime][:ot_type].should == "byo-yomi"
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