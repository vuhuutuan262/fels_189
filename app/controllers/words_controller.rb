class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = current_user
    @categories = Category.all
    filter_state = params[:filter_state] || :get_all
    @word = Word.in_category(params[:category_id]).send(filter_state,
      current_user).paginate page: params[:page],
      per_page: Settings.show_words_user_view
  end

  private
  def word_correct_answer
    @word.answers.select{|answer| answer.is_correct?}
  end
end
