require 'spec_helper'

describe SessionsController do
  render_views

  describe "login page" do
    it "should be accessible" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @attr = { :email => "", :password => "" }
    end

    describe "failure" do
      it "should re-render the 'new' page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

    end
  end

end