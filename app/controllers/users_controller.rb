class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, except: [:new, :create, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: [:destroy]

  def show
    @lessons = current_user.lessons.paginate page: params[:page],
      per_page: Settings.users_show_lessons
    @activities = @user.activities.order(created_at: :desc).
      paginate page: params[:page], per_page: Settings.per_act
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
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

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "user_deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, 
      :password_confirmation, :avatar
  end

  def find_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
