# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Creating membership plans, and making the Rails application aware of the membership plans
# Will insert these records to the db through this seeds file
Plan.create(name: 'basic', price: 0)
Plan.create(name: 'pro', price: 10)