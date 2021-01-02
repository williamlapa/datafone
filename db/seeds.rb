# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts 'Cleaning the db...'

# Customer.destroy_all

puts 'db is clean'

user = User.create(email: 'datafone@email.com', password: '123123', role: 'adm')

puts 'creating customers...'

2.times do
  customer = Customer.create(
    name: Faker::Restaurant.name,
    address: 'Rua Conselheiro Nabuco, Recife, Pernambuco, Brasil',
    value: [100, 200, 300, 400, 500, 600].sample,
    customer_since: '2015/01/01',
    zone: 'zona norte',
    user_id: 1
  )

  puts "#{customer.id}-#{customer.name} was created"
end

2.times do
  customer = Customer.create(
    name: Faker::Restaurant.name,
    address: 'Avenida Visconde de Jequitinhonha, Recife, Pernambuco, Brasil',
    value: [100, 200, 300, 400, 500, 600].sample,
    customer_since: '2015/01/01',
    zone: 'zona sul',
    user_id: 1
  )

  puts "#{customer.id}-#{customer.name} was created"
end
