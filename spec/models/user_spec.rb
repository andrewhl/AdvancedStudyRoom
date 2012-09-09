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
    subject(:admin) { FactoryGirl.create(:admin) }

    it { should be_valid }


  end

end
