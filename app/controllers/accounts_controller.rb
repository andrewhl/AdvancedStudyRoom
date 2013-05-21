class AccountsController < ApplicationController

  load_and_authorize_resource
  before_filter :authorize

  before_filter :find_user
  before_filter :find_account, only: [:index, :show, :edit, :update, :destroy]
  before_filter :add_accounts_breadcrumbs, only: [:new, :edit]

  def index
    redirect_to user_path(@user)
  end

  def show
    redirect_to edit_user_account_path(@user, @account)
  end

  def new
    redirect_to user_path(@user),
      flash: {alert: 'You already have an account on all servers'} if @user.accounts.count == Server.count

    add_breadcrumb 'New', :new
    @account = @user.accounts.build
  end

  def create
    @account = @user.accounts.build(params[:account])
    @account.server = Server.find_by_name("KGS")
    if @account.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
    add_breadcrumb 'Edit', :edit
  end

  def update
    if @account.update_attributes(params[:account])
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = 'Account deleted' if @account.destroy
    redirect_to user_path(@user)
  end

  private

    def find_user
      @user = User.find(params[:user_id])
    end

    def find_account
      @account = @user.accounts.find(params[:id])
    end

    def add_accounts_breadcrumbs
      @show_breadcrumbs = true if current_user.admin?
      add_breadcrumb 'Users', users_path
      add_breadcrumb @user.username, user_path(@user)
      add_breadcrumb 'Accounts', user_accounts_path(@user)
    end

end
