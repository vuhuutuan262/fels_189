class Answer < ApplicationRecord
  has_many :result

  belongs_to :word, inverse_of: :answers

  validates :content, presence: true
end
