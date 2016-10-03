User.create!(name: "Chu Kim Thang", email: "chukimthang94@gmail.com",
  password: "123456", password_confirmation: "123456", admin: true)

User.create!(name: "Vu Huu Tuan", email: "tuan@gmail.com",
  password: "123456", password_confirmation: "123456")

40.times do |n|
  name = "user#{n}"
  email = "email#{n}@email.com"
  password = "123456"
  password_confirmation = "123456"

  User.create name: name, email:email, password: password,
    password_confirmation: password_confirmation
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
