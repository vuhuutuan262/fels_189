class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "fels"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def find_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
  end
end