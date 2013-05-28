class ApplicationController < ActionController::Base

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |ex|
    flash[:error] = "Access denied!"
    flash[:error] << "#{ex.subject} || #{ex.action}" if Rails.env.development?
    render 'pages/home', status: :forbidden
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