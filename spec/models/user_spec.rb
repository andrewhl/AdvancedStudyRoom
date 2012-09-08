require 'spec_helper'

describe User do

  # before(:each) do
    # @user = FactoryGirl.create(:user)
  # end

  describe "user authentication" do
    it "should create a new instance given a valid attribute" do
      user = FactoryGirl.create(:user)
      user.should be_valid
    end

    it "should not create a new instance given an invalid attribute" do
      user = User.create(:email => "foo@")
      user.should_not be_valid
    end
  end

  describe "admin users" do
    let(:admin) { FactoryGirl.create(:admin) }
    subject { admin }

    it { should be_valid }


  end

end
