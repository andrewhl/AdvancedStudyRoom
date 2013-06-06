class ApplicationController < ActionController::Base

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |ex|
    respond_to do |format|
      format.html do
        flash[:error] = "You are not authorized to access this page"
        flash[:error] << " || #{ex.subject} || #{ex.action}" if Rails.env.development?
        redirect_to current_user ? root_path : login_path
      end
      format.json do
        render text: 'Not Authorized', status: :forbidden
      end
    end
  end

  def initialize
    @title = []
    @body_class = []
    super
  end

  private

    def authorize
      redirect_to login_url, alert: "Not authorized" if current_user.nil?
    end
end