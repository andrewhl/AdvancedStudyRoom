require 'spec_helper'
require 'downloader'
require 'pry'

describe Downloader do
  subject(:archive) {
    Downloader.new("support/kabradarf-2012-9.zip")
  }

  context "initialization" do
    it { should respond_to :download_games }

  end

  describe "validate individual games" do
    let(:sgf_file) { "DrGoPlayer-kabradarf.sgf" }

    it "should receive an sgf file" do
      archive.download_game(sgf_file).should be_an_instance_of(String)
    end

    it "should open the sgf file" do
      pending
    end

    it "should return true if it has a valid tag" do
      # binding.pry
      archive.download_game(sgf_file).should be_true
    end



  end
end