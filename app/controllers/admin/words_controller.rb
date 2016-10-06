class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_word, except: [:new, :create, :index]

  def index
    @words = Word.paginate page: params[:page],
      per_page: Settings.admin_show_words
  end

  def show
  end

  def new
    @word = Word.new
    Settings.answers_num_default.times {@word.answers.build}
    @category_id = params[:category_id]
    load_categories
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "add_word"
      redirect_to :back
    else
      load_categories
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t :update
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    @word.destroy
    flash[:success] = t "word_deleted"
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :title, :category_id, :picture,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def find_word
    @word = Word.find_by_id params[:id]
    if @word.nil?
      flash[:danger] = t "word_not_found"
      redirect_to admin_words_path
    end
  end
end
