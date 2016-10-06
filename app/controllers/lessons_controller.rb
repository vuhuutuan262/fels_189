class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_exam, only: [:update, :show]

  def index
  end

  def new
    @lesson = Lesson.new
    load_categories
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      flash[:success] = t :add_lesson
      redirect_to lessons_path
    else
      load_categories
      render :new
    end
  end

  def show
    @lesson = Lesson.includes(results: [:answer, word: :answers]).
      find_by id: params[:id]
  end

  def update
    if @lesson.deadline.nil?
      @lesson.update_attributes lesson_params
    else
      if @lesson.time_out?
        flash.now[:danger] = t :timeout
        redirect_to lessons_path
      else
        @lesson.update_attributes lesson_params
        redirect_to lessons_path
      end
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id, :is_finish,
      :deadline, results_attributes: [:id, :answer_id, :is_correct]
  end

  def find_exam
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.nil?
      flash.now[:danger] = t :not_available
      redirect_to lessons_path
    end
  end
end
