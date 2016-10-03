class Category < ApplicationRecord
  has_many :lessons
  has_many :words

  validates :name, presence: true
end
