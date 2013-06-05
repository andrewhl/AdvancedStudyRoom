class Admin::UserAccountsController < ApplicationController

  load_and_authorize_resource :user, only: [:new, :create]
  load_and_authorize_resource :account, shallow: true, through_association: :user
  before_filter :add_breadcrumbs

  def new
  end

  def create
    @account = @user.accounts.build(params[:account])
    if @account.save
      redirect_to admin_account_path(@account), flash: {success: 'The account was created'}
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @account.update_attributes(params[:account])
      redirect_to admin_user_path(@account.user), flash: {success: 'The account was updated'}
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = 'The account was deleted' if @account.destroy
    redirect_to admin_user_path(@account.user)
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      user = @user || @account.user
      add_breadcrumb 'Users', admin_users_path
      add_breadcrumb user.username, admin_user_path(user)
      add_breadcrumb 'Add Account', :new if %W(new create).include? params[:action]
      add_breadcrumb 'Edit Account', :edit if %W(edit update).include? params[:action]
    end

end

