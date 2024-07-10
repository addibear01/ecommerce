# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   endrequire 'faker'

# Ensure we start fresh
require 'faker'

# Ensure we start fresh by deleting all records in the correct order
TeddyType.delete_all
Category.delete_all

# Create 4 Categories
categories = [
  Category.create!(category_name: 'Limited Teddies', created_at: Time.now, updated_at: Time.now),
  Category.create!(category_name: 'New Teddies', created_at: Time.now, updated_at: Time.now),
  Category.create!(category_name: 'Recently Updated', created_at: Time.now, updated_at: Time.now),
  Category.create!(category_name: 'Seasonal Teddies', created_at: Time.now, updated_at: Time.now)
]

# Create 10 Teddy Types (Products)
teddy_types = [
  TeddyType.create!(teddy_name: 'Black Teddy', description: 'A timeless black Teddy with lusish.', price: 29.99, stock_quantity: 50, category: categories[0], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Polar Teddy', description: 'A sleek, modern polar Teddy.', price: 39.99, stock_quantity: 30, category: categories[1], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Red Panda', description: 'A beautifal red panda that gives great hugs.', price: 99.99, stock_quantity: 10, category: categories[2], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Seasonal Spring Teddy', description: 'A teddy Teddy dressed for Spring.', price: 49.99, stock_quantity: 20, category: categories[3], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Brown Teddy', description: 'A brown classic teddy Teddy.', price: 29.99, stock_quantity: 40, category: categories[0], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Birthday Teddy', description: 'A sleek, birthday teddy.', price: 39.99, stock_quantity: 30, category: categories[1], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Silver Teddy', description: 'A new edition silver teddy.', price: 89.99, stock_quantity: 15, category: categories[2], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Panda Teddy', description: 'A cute, fluffy panda bear.', price: 49.99, stock_quantity: 25, category: categories[3], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Blue Teddy', description: 'A blue classic teddy Teddy.', price: 29.99, stock_quantity: 35, category: categories[0], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Purple Teddy', description: 'A sleek, purple modern teddy.', price: 39.99, stock_quantity: 30, category: categories[1], created_at: Time.now, updated_at: Time.now)
]
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?