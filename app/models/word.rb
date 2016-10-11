class Word < ApplicationRecord
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :answers, inverse_of: :word, dependent: :destroy
  has_many :lessons, through: :results

  mount_uploader :picture, PictureUploader

  validates :title, presence: true
  validate :answers_size
  validate :check_correct_answer
  validate :picture_size

  scope :in_category, ->category_id{
    where category_id: category_id if category_id.present?}
  scope :get_all, ->title{where("id IN(SELECT id FROM words)")}
  scope :learned, ->user{where("id IN (
    SELECT word_id FROM results WHERE lesson_id IN ( 
      SELECT id FROM lessons WHERE user_id = ?))",user.id)}
  scope :not_learned, ->user{where("id NOT IN (
    SELECT word_id FROM results WHERE lesson_id IN (
      SELECT id FROM lessons WHERE user_id = ?))",user.id)}

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  scope :filter_title, -> search_title{
    where("words.title LIKE '%#{search_title}%'")}

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

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
