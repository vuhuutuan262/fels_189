class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, only: :show

  def index
    @user = User.all.paginate page: params[:page],
      per_page: Settings.admin_show_user
  end

  def show
    @lessons = @user.lessons.paginate page: params[:page],
      per_page: Settings.users_show_lessons
  end

  def destroy
    @user = User.find_by_id params[:id]
    @user.destroy
    flash[:success] = t "user_deleted"
    redirect_to admin_users_path
  end

  private
  def find_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
  end
end
