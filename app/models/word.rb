class Word < ApplicationRecord
  belongs_to :category

  has_many :results
  has_many :answers, inverse_of: :word
  has_many :lessons, through: :results

  validates :title, presence: true
  validate :answers_size
  validate :check_correct_answer

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  private
  def answers_size
    errors.add :word, I18n.t("answer_size") if answers.size < 2
  end

  def check_correct_answer
    correct_answer = answers.select {|answers| answers.is_correct?}
    errors.add :correct_answer,
      I18n.t("need_avaliable") if correct_answer.empty?
    errors.add :correct_answer,
      I18n.t("no_more_than_one") if correct_answer.size > 1
  end
end
