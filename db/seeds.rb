# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# Set products
barcodes = [
  '0647460819',
  '0095722179',
  '0891190639',
  '0610452091',
  '0281550631',
  '0830188127',
  '0106977745',
  '0593847858',
  '0091622062',
  '0999988646'
]
products = barcodes.map do |barcode|
  {
    name: Faker::Food.vegetables,
    barcode: barcode,
    price: Faker::Number.between(from: 100, to: 1000),
  }
end

Product.create!(products)
puts 'Products set'
