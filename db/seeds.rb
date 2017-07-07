# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RegisteredApp.create({email_address: 'project-mathcraft', password: 'fishsticks'})

max_level = 15
while Experience.count < max_level
  i = Experience.count
  exp = i ** 3
  Experience.create({ level: i, experience_needed: exp })
end
