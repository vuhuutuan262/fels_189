class Activity < ApplicationRecord
  belongs_to :user

  validates :activity_type, presence: true
  validates :target_id, presence: true
  validates :user_id, presence: true

  scope :action, ->user{where "user_id = ?", user.id}

  enum activity_type: {start_lesson: 1, followed: 2, unfollowed: 3}

  def find_user id
    User.find_by id: id
  end

  def find_lesson
    Lesson.find_by id: self.target_id
  end
end
