class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :results
  has_many :words, through: :results

  before_create :generate_results

  validate :category_word_count

  accepts_nested_attributes_for :results,
    reject_if: proc {|attribute| attribute[:answer_id].blank?}

  def generate_results
    self.words = category.words.shuffle().take(Settings.words_minimum)
  end

  private
  def category_word_count
    errors.add :category, I18n.t("not_enough") unless category.words.count>=
      Settings.words_minimum
  end
end
