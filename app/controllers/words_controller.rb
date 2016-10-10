class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = current_user
    @word = Word.all.paginate page: params[:page],
      per_page: Settings.show_words_user_view
  end

  private
  def word_correct_answer
    @word.answers.select{|answer| answer.is_correct?}
  end
end
