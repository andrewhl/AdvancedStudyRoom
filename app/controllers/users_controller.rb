class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :flash => {:info => "Thank you for signing up!"}
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @accounts = @user.accounts
  end

end