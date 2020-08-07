User.create!(username: "admin",
             name:  "Example User",
             email: "example@railstutorial.org",
             password:              "qXxTJU+SVdFD#C$hF7qd",
             password_confirmation: "qXxTJU+SVdFD#C$hF7qd",
             admin: true)

99.times do |n|
  username =  SecureRandom.hex(5)
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               username: username,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  url = "https://" + SecureRandom.hex(10)
  users.each { |user| user.microposts.create!(title: title,url:url) }
end