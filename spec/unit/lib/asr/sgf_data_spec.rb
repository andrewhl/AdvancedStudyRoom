require 'spec_helper'

describe ASR::SGFData do

  subject(:sgf_data) {
    ASR::SGFData.new file_path: "./spec/support/DrGoPlayer-kabradarf.sgf"
  }

  it { should be_true }

  context "#data" do
    it "should prepare its data using SGFPreparer" do
      ASR::SGFPreparer.any_instance.expects(:data).returns({})
      sgf_data = ASR::SGFData.new(file_path: "./spec/support/DrGoPlayer-kabradarf.sgf")
      sgf_data.data
    end
  end

end