class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_category, except: [:new, :create, :index]

  def index
  end

  def show
    @words = @category.words.paginate page: params[:page],
      per_page: Settings.admin_show_words
  end

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "add_category"
      redirect_to new_admin_category_path
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :update
      redirect_to new_admin_category_path
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "user_deleted"
    redirect_to new_admin_category_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by_id params[:id]
    if @category.nil?
      flash[:danger] = t "category_not_found"
      redirect_to root_path
    end
  end
end
