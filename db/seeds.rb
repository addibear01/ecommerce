require 'faker'

# Ensure we start fresh
TeddyType.delete_all
Category.delete_all
Page.delete_all
Province.delete_all

# Create 4 Categories
categories = [
  Category.create!(category_name: 'Limited Teddies', created_at: Time.now, updated_at: Time.now),
  Category.create!(category_name: 'New Teddies', created_at: Time.now, updated_at: Time.now),
  Category.create!(category_name: 'Recently Updated', created_at: Time.now, updated_at: Time.now),
  Category.create!(category_name: 'Seasonal Teddies', created_at: Time.now, updated_at: Time.now)
]

# Create Provinces
provinces = [
  Province.create!(id: 1, name: 'Manitoba'),
  Province.create!(id: 2, name: 'Alberta'),
  Province.create!(id: 3, name: 'Ontario'),
  Province.create!(id: 4, name: 'Nova Scotia'),
  Province.create!(id: 5, name: 'Quebec'),
  Province.create!(id: 6, name: 'New Brunswick')
]

# Create 10 Teddy Types (Products)
teddy_types = [
  TeddyType.create!(teddy_name: 'Black Teddy', description: 'A timeless black Teddy with luscious fur.', price: 29.99, stock_quantity: 50, category: categories[0], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Polar Teddy', description: 'A sleek, modern polar Teddy.', price: 39.99, stock_quantity: 30, category: categories[1], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Red Panda', description: 'A beautiful red panda that gives great hugs.', price: 99.99, stock_quantity: 10, category: categories[2], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Seasonal Spring Teddy', description: 'A teddy dressed for Spring.', price: 49.99, stock_quantity: 20, category: categories[3], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Brown Teddy', description: 'A brown classic teddy.', price: 29.99, stock_quantity: 40, category: categories[0], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Birthday Teddy', description: 'A sleek, birthday teddy.', price: 39.99, stock_quantity: 30, category: categories[1], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Silver Teddy', description: 'A new edition silver teddy.', price: 89.99, stock_quantity: 15, category: categories[2], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Panda Teddy', description: 'A cute, fluffy panda bear.', price: 49.99, stock_quantity: 25, category: categories[3], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Blue Teddy', description: 'A blue classic teddy.', price: 29.99, stock_quantity: 35, category: categories[0], created_at: Time.now, updated_at: Time.now),
  TeddyType.create!(teddy_name: 'Purple Teddy', description: 'A sleek, purple modern teddy.', price: 39.99, stock_quantity: 30, category: categories[1], created_at: Time.now, updated_at: Time.now)
]

# Debug statement
puts "Creating About Page"
Page.find_or_create_by!(slug: "about") do |page|
  page.title = "About Us"
  page.content = "<p>This is the about page content.</p>"
end

# Debug statement
puts "Creating Contact Page"
Page.find_or_create_by!(slug: "contact") do |page|
  page.title = "Contact Us"
  page.content = "<p>This is the contact page content.</p>"
end

# Create Admin User if it doesn't already exist
AdminUser.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end if Rails.env.development?
