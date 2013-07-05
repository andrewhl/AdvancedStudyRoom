require 'spec_helper'

describe ASR::SGFValidator do

  # let!(:sgf_data_object) { ASR::SGFData.new(file_path: "./spec/support/DrGoPlayer-kabradarf.sgf") }

  subject(:sgf_validator) { ASR::SGFValidator.new handle: "kabradarf" }

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
    it "should return true if sgf_data is valid" do
      sgf_data = FactoryGirl.build(:sgf_data)
      sgf_validator.validate(sgf_data).should be_true
    end
  end

  # context '#validate' do

  #   before(:each) do
  #     @division = FactoryGirl.create(:division)
  #     @wp_registration = FactoryGirl.create(:registration, handle: 'DrGoPlayer', division: @division)
  #     @bp_registration = FactoryGirl.create(:registration, handle: 'kabradarf', division: @division)
  #   end

  #   it 'should be valid' do
  #     sgf_validator.validate(sgf_data_object).should be_true
  #   end

  #   it 'should return false if result is nil' do
  #     sgf_data_object.data[:result] = nil
  #     sgf_validator.validate(sgf_data_object).should be_false
  #   end

  #   it 'should return false if the player is not in the game' do
  #     sgf_data_object.data[:white_player] = 'hello'
  #     sgf_data_object.data[:black_player] = 'world'
  #     sgf_validator.validate(sgf_data_object).should be_false
  #   end

  #   it "should return false if one player is not in the same division" do
  #     new_division = FactoryGirl.create(:division)
  #     @bp_registration.update_attribute :division, new_division
  #     sgf_validator.validate(sgf_data_object).should be_false
  #   end

  #   it "should return false if player is not registered" do
  #     sgf_data_object.data[:white_player] = 'hello'
  #     sgf_validator.validate(sgf_data_object).should be_false
  #   end
  # end

end
