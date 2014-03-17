class Admin::UsersController < ApplicationController

  authorize_resource :user
  before_filter :load_user, except: [:index]
  before_filter :add_breadcrumbs

  def index
    @users = User.includes(:accounts)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user], without_protection: true)
      redirect_to admin_user_path(@user), flash: {success: 'User updated' }
    else
      render :edit
    end
  end

  def destroy
    is_oneself = current_user.id == @user.id
    if is_oneself
      flash[:error] = 'You can\' delete yourself'
    elsif !@user.destroy
      flash[:error] = 'Error while deleting user'
    end
    redirect_to admin_users_path
  end

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Users', admin_users_path
      add_breadcrumb @user.username, admin_user_path(@user) if @user
      add_breadcrumb 'Add', :add if %W(new create).include? params[:action]
      add_breadcrumb 'Edit', :edit if %W(edit update).include? params[:action]
    end

    def load_user
      @user = User.find_by_id(params[:id])
    end

end
