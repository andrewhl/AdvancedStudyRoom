# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  username            :string(255)
#  access_level        :integer
#  password_reset_flag :boolean
#  last_signed_in      :datetime
#  last_scraped        :datetime
#  points              :float
#  month_points        :float
#  lifetime_points     :float
#  first_name          :string(255)
#  last_name           :string(255)
#  password_digest     :string(255)
#  admin               :boolean
#  rank                :integer
#  kgs_rank            :integer
#  kaya_rank           :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
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
