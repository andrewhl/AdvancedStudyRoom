require 'spec_helper'

describe SignupController do

  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    before :each do
      @user_attrs = FactoryGirl.attributes_for(:user, username: 'signup_user')
      @user_attrs[:accounts_attributes] = [FactoryGirl.attributes_for(:account)]
    end

    it "assigns the account server to be KGS" do
      post 'create', user: @user_attrs
      account = User.find_by_username('signup_user').accounts.first
      account.server.should == Server.find_by_name('KGS')
    end

    it "redirects to profile" do
      post 'create', user: @user_attrs
      expect(response).to redirect_to(profile_path)
    end
  end

end
