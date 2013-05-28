class UsersController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize
  before_filter :initialize_params

  def index
    @users = User.order("#{params[:sort]} #{params[:direction]}")
  end

  def new
    @user = User.new
    @user.accounts.build
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      return redirect_to :index
    end
    render :new
  end

  def show
    @user = User.find(params[:id], include: {accounts: [:server, :registrations]})
    render :profile
  end

  def profile
    @user = User.find(current_user.id, include: {accounts: [:server, :registrations]})
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

  private

    def initialize_params
      params[:sort]      ||= "username"
      params[:direction] ||= "desc"
    end

end