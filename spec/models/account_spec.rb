# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  handle     :string(255)
#  user_id    :integer
#  server_id  :integer
#  rank       :integer
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Account do

  before(:each) do
    @account = FactoryGirl.create(:account)
  end

  describe "authentication" do
    it "should create a new instance given a valid attribute" do
      @account.should be_valid
    end

    it "should not create a new instance without a handle or a rank" do
      account = Account.create()
      account.should_not be_valid
    end

    it "should not create a new instance without a rank" do
      account = Account.create(:handle => "test")
      account.should_not be_valid
    end

    it "should not create a new instance without a handle" do
      account = Account.create(:rank => 4)
      account.should_not be_valid
    end

    it "should allow multiple users with the same username (in different servers)" do
      account2 = FactoryGirl.create(:account)
      # user2.should be_valid
      Account.count.should == 2
    end

  end

end
