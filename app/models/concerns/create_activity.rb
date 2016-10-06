module CreateActivity
  def create_activity name, target_id, user_id
    Activity.create! name: name, target_id: target_id, user_id: user_id
  end
end
