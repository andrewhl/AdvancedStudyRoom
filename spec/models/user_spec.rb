# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string(255)      default(""), not null
#  username               :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#

require 'spec_helper'

describe User do

  before(:each) do
    @user = FactoryGirl.build(:user, :email => "test@test.com")
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

    it "should not allow multiple users with the same email" do
      @user.save
      user2 = FactoryGirl.build(:user, :email => "test@test.com").should_not be_valid
    end

  end

  describe "admin users" do
    subject(:admin) { FactoryGirl.create(:user, admin: true) }
    it { should be_valid }
  end

end
