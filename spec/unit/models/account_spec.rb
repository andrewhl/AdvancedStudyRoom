# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  handle     :string(255)
#  user_id    :integer
#  server_id  :integer
#  rank       :integer
#  private    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Account do

  describe "authentication" do
    it "should create a new instance given a valid attribute" do
      account = FactoryGirl.build(:account)
      account.should be_valid
    end

    it "should not create a new instance without a handle or a rank" do
      account = Account.new
      account.should_not be_valid
    end

    it "should not create a new instance without a rank" do
      account = Account.new(:handle => "test")
      account.should_not be_valid
    end

    it "should not create a new instance without a handle" do
      account = Account.new(:rank => 4)
      account.should_not be_valid
    end

  end

end
