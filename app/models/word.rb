class Word < ApplicationRecord
  belongs_to :category

  has_many :result
  has_many :answer
end
