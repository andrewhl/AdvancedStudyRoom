require 'spec_helper'
require 'unzipper'


describe Unzipper do

  let(:path) { "support/kabradarf-2012-9.zip" }
  subject(:file) { Unzipper.new(:path) }

  it "should initialize" do
    lambda { Unzipper.new(:path) }.should_not raise_error
  end

  it "should unzip" do
    file.unzip("/test/").should_not raise_error
  end
end