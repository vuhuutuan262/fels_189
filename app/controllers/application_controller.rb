class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = t "Please_log_in."
      redirect_to login_path
    end
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
