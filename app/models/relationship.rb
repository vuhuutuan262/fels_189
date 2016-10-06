class Relationship < ApplicationRecord
  include CreateActivity

  after_save :create_follow_activity
  before_destroy :create_unfollow_activity

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  private
  def create_follow_activity
    create_activity Settings.activities.followed, followed_id, follower_id
  end

  def create_unfollow_activity
    create_activity Settings.activities.unfollowed, followed_id, follower_id
  end
end
