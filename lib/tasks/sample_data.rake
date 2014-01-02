namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Juan Carlos Espinosa Ceniceros",
                 username: "jcespinosa",
                 email: "juan@mail.com",
                 password: "abc_123",
                 password_confirmation: "abc_123",
                 admin: true)

    10.times do |n|
      name  = Faker::Name.name
      username = "example-#{n+1}"
      email = "example-#{n+1}@mail.com"
      password  = "password"
      User.create!(name: name,
                   username: username,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 5)
    10.times do
      name = Faker::Lorem.sentence(1)
      description = Faker::Lorem.sentence(5)
      users.each { |user| user.projects.create!(name: name, description: description) }
    end

  end
end