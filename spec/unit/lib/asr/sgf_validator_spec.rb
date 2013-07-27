require 'spec_helper'

describe ASR::SGFValidator do

  subject(:sgf_validator) { ASR::SGFValidator.new handle: "kabradarf" }
  let(:sgf_data) { FactoryGirl.build(:sgf_data) }

  context '#handle' do
    it 'returns an unmodified handle if ignore_case is false' do
      sgf_validator.ignore_case = false
      sgf_validator.handle = 'DrGoPlayer'
      sgf_validator.handle.should == 'DrGoPlayer'
    end

    it 'returns an downcased handle if ignore_case is true' do
      sgf_validator.ignore_case = true
      sgf_validator.handle = 'DrGoPlayer'
      sgf_validator.handle.should == 'drgoplayer'
    end
  end

  context '#validate' do
    before(:each) { Event.stubs(:check_registration_parity).returns(true) }

    it "should return true if sgf_data is valid" do
      sgf_validator.validate(sgf_data).should be_true
    end

    it "should return false if the black player is missing" do
      sgf_data.black_player = nil
      sgf_validator.validate(sgf_data).should be_false
    end

    it "should return false if the white player is missing" do
      sgf_data.white_player = nil
      sgf_validator.validate(sgf_data).should be_false
    end

    it "should return false if there is no result" do
      sgf_data.result = nil
      sgf_validator.validate(sgf_data).should be_false
    end

    it "should return false if there is no win_info" do
      sgf_data.result = { win_info: '' }
      sgf_validator.validate(sgf_data).should be_false
    end

    it "should return false if the given handle is not in the game" do
      sgf_validator.handle = 'helloworld'
      sgf_validator.validate(sgf_data).should be_false
    end

    it "should return false if the registrations have no parity" do
      Event.stubs(:check_registration_parity).returns(false)
      sgf_validator.validate(sgf_data).should be_false
    end
  end
end
