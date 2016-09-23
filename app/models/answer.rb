class Answer < ApplicationRecord
  has_many :result

  belongs_to :word
end
