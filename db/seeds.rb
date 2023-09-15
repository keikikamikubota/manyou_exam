# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "かんりしゃ", email: "admin@example.com",
            password: 'admin', password_confirmation: 'admin', admin: true)

10.times do |n|
  User.create!(name: "シードくん#{n + 1}",
               email: "seedtest#{n + 1}@test.com",
               password: "password#{n + 1}",
               password_confirmation: "password#{n + 1}"
               )
end

User.all.each do |user|
  user.tasks.create!(
    name: 'シード',
    content: 'シードテキスト'
  )
end

label_array = ['今週中', '今月中', 'Rails', 'アウトプット', '就活', 'プライベート', '読書', '運動', '遊ぶ', '卒業課題' ]
10.times do |n|
  Label.create(title: label_array[n])
end