class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      user.admin? ? redirect_to(admin_home_path) : redirect_to(user)
    else
      flash[:danger] = t "login_danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
