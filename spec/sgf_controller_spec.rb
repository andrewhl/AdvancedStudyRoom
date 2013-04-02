['spec_helper', 'sgf_controller', 'sgf_data', 'pry'].each { |x| require x }

describe ASR::SGFController do

  subject(:controller) {
    ASR::SGFController.new
  }

  let!(:file_path) { "./spec/DrGoPlayer-kabradarf.sgf" }

  describe "SGF Data" do

    let!(:sgf) { ASR::SGFData.new file_path: "./spec/DrGoPlayer-kabradarf.sgf" }

    it "should respond to create sgf" do
      controller.should respond_to(:create_sgf)
    end

    it "should create an sgf from a path" do
      controller.create_sgf(file_path: file_path).should be_an_instance_of(ASR::SGFData)
    end

  end

  describe "SGF Cleanup" do

    context "without sgf" do

      it "should raise an error if the sgf is not defined" do
        expect { controller.clean_sgf }.to raise_error
      end

    end

    context "with sgf" do

      it "should have unformatted values" do
        controller.create_sgf(file_path: file_path)
        controller.sgf.data[:overtime].should == "5x30 byo-yomi"
        controller.sgf.data[:white_player].should == "DrGoPlayer"
      end

      it "should return an sgf with clean values" do
        controller.create_sgf(file_path: file_path)
        controller.clean_sgf
        binding.pry
        controller.sgf
      end

    end

  end

end