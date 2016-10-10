module CreateActivity
  def create_activity activity_type, target_id, user_id
    Activity.create activity_type: activity_type, target_id: target_id,
      user_id: user_id
  end
end
