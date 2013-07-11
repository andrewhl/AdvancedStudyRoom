require 'spec_helper'

describe ASR::SGFData do

  subject(:sgf_data) { FactoryGirl.build(:sgf_data) }

  it { should be_true }

  context "#data" do
    it "should prepare its data using SGFPreparer" do
      ASR::SGFPreparer.any_instance.expects(:data).returns({})
      sgf_data = FactoryGirl.build(:sgf_data, use_file: true)
      sgf_data.data
    end
  end

end