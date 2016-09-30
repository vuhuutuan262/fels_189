class LessonsController < ApplicationController
  before_action :logged_in_user

  def index
  end

  def new
    @lesson = Lesson.new
    load_categories
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      flash[:success] = t "add_lesson"
      redirect_to lessons_path
    else
      load_categories
      render :new
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      results_attributes: [:id, :answer_id]
  end
end
