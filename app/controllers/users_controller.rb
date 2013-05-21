class UsersController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize, except: [:signup, :process_signup]

  before_filter :build_user, only: [:new, :signup]

  def profile
    @user = User.find(current_user.id, include: {accounts: [:server, :registrations]})
  end

  def show
    @user = User.find(params[:id], include: {accounts: [:server, :registrations]})
    render :profile
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, flash: {success: 'User updated.'}
    else
      render :edit
    end
  end

  def toggle_admin
    return redirect_to :users, flash: {notice: 'You cannot de-admin yourself.'} if @user == current_user
    @user = User.find(params[:id])
    if @user.update_attribute(:admin, !@user.admin?)
      redirect_to :users, flash: {success: 'User updated.'}
    else
      render :index
    end
  end

  def new
  end

  def signup
  end

  def process_signup
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      return redirect_to profile_path, flash: {info: 'Thank you for signing up!'}
    end
    render :signup
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      return redirect_to :index
    end
    render :new
  end

  private

    def build_user
      @user = User.new
      @user.accounts.build
    end

end