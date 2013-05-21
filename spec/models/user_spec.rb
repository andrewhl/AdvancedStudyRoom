# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  admin               :boolean          default(FALSE), not null
#  email               :string(255)
#  username            :string(255)
#  password_digest     :string(255)
#  password_reset_flag :boolean
#  last_signed_in      :datetime
#  first_name          :string(255)
#  last_name           :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "authentication" do
    it "should create a new instance given a valid attribute" do
      # user = FactoryGirl.create(:user)
      @user.should be_valid
    end

    it "should not create a new instance given an invalid attribute" do
      user = FactoryGirl.build(:user, :email => "foo@")
      user.should_not be_valid
    end

    it "should not allow multiple users with the same username" do
      user2 = FactoryGirl.build(:user, :email => "test@test.com").should_not be_valid
    end

  end

  describe "admin users" do
    subject(:admin) { FactoryGirl.create(:admin) }

    it { should be_valid }


  end

end
