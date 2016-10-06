class Answer < ApplicationRecord
  has_many :results, dependent: :destroy

  belongs_to :word, inverse_of: :answers

  validates :content, presence: true
end
