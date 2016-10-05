class Activity < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :target_id, presence: true
  validates :user_id, presence: true
end
