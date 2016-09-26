class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin, only: [:new, :create]

  def index
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

  private
  def category_params
    params.require(:category).permit :name
  end
end
