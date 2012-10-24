require 'spec_helper'
require 'validator'
require 'pry'

describe Validator do
  subject(:archive) {
    Validator.new("support/kabradarf-2012-9.zip")
  }

  context "initialization" do
    it { should respond_to :validate_games }

  end

  describe "validate individual games" do
    let(:sgf_file) { "support/2012/9/1/DrGoPlayer-kabradarf.sgf" }

    it "should receive an sgf file" do
      archive.validate_game(sgf_file).should be_an_instance_of(String)
    end

    it "should open the sgf file" do
      pending
    end



  end
end