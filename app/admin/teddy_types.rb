# app/admin/teddy_types.rb
ActiveAdmin.register TeddyType do
  permit_params :teddy_name, :description, :price, :stock_quantity, :category_id, :image, :on_sale
  controller do
    helper TeddyTypesHelper
  end
  scope :all
  scope :on_sale
  scope :new_products
  scope :recently_updated
  filter :teddy_name
  filter :description
  filter :price
  filter :stock_quantity
  filter :on_sale
  filter :category
  index do
    selectable_column
    id_column
    column :teddy_name
    column :description
    column :price
    column :stock_quantity
    column :on_sale
    column 'Category', sortable: :category_id, &:category_name
    column 'Image' do |teddy_type|
      image_variant(teddy_type, :small)
    end
    column :created_at
    column :updated_at
    actions
  end
  show do
    attributes_table do
      row :id
      row :teddy_name
      row :description
      row :price
      row :stock_quantity
      row :category
      row :on_sale
      row :image do |teddy_type|
        image_variant(teddy_type, :large)
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  form do |f|
    f.inputs do
      f.input :teddy_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category
      f.input :on_sale
      f.input :image, as: :file
    end
    f.actions
  end
end
