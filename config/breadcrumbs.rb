crumb :root do
  link "Home", root_path
end

crumb :categories do
  link "Categories", categories_path
  parent :root
end

crumb :category do |category|
  link category.name, category_path(category)
  parent :categories
end

crumb :teddy_types do
  link "Teddy Types", teddy_types_path
  parent :root
end

crumb :teddy_type do |teddy_type|
  link teddy_type.teddy_name, teddy_type_path(teddy_type)
  parent :teddy_types
end
