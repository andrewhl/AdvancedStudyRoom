class Admin::UsersController < ApplicationController

  load_and_authorize_resource :user
  before_filter :add_breadcrumbs

  def index
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

  private

    def add_breadcrumbs
      @show_breadcrumbs = true
      add_breadcrumb 'Users', admin_users_path
      add_breadcrumb @user.name, admin_user_path(@user) if @user
      add_breadcrumb 'Add', :add if %W(new create).include? params[:action]
      add_breadcrumb 'Edit', :edit if %W(edit update).include? params[:action]
    end

end
