# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
<<<<<<< HEAD
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
=======
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  email: 'admin@gmail.com',
  fname: 'Admin',
  lname: 'Admin',
  role: 'Admin',
  password: '123456',
  password_confirmation: '123456'
)

User.create!(
  email: 'member@gmail.com',
  fname: 'John',
  lname: 'Doe',
  role: 'Member',
  password: '123456',
  password_confirmation: '123456'
)

3.times do |x|
  User.create!(email: "test#{x}@gmail.com", fname: 'Sean', lname: 'Lee', role: 'Member', password: '123456', password_confirmation: '123456')
end

3.times do |x|
  Transaction.create!(email: "test#{x}@gmail.com", serial_number: "#{x}1#{x}2#{x}3")
end

10.times do |x|
  Item.create!(name: "Item #{x}", serial_number: rand.to_s[2..11], description: "Description of item #{x}" , available: true)
end
>>>>>>> editTest
