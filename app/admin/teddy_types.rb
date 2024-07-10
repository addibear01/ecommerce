ActiveAdmin.register TeddyType do
  permit_params :teddy_name, :description, :price, :stock_quantity, :category_id

  index do
    selectable_column
    id_column
    column :teddy_name
    column :description
    column :price
    column :stock_quantity
    column "Category", sortable: :category_id do |teddy_type|
      teddy_type.category.category_name
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :teddy_name
  filter :description
  filter :price
  filter :stock_quantity
  filter :category
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :teddy_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category, as: :select, collection: Category.all.collect { |category| [category.category_name, category.id] }
    end
    f.actions
  end
end
