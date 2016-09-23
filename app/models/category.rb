class Category < ApplicationRecord
  has_many :lesson
  has_many :word
end
