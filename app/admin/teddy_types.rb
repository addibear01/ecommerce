ActiveAdmin.register TeddyType do
  permit_params :teddy_name, :description, :price, :stock_quantity, :category_id, :image, :on_sale

  scope :all, default: true
  scope :on_sale do |teddy_types|
    teddy_types.on_sale
  end
  scope :new_products do |teddy_types|
    teddy_types.new_products
  end
  scope :recently_updated do |teddy_types|
    teddy_types.recently_updated
  end

  index do
    selectable_column
    id_column
    column :teddy_name
    column :description
    column :price
    column :stock_quantity
    column :on_sale
    column "Category", sortable: :category_id do |teddy_type|
      teddy_type.category.category_name
    end
    column "Image" do |teddy_type|
      if teddy_type.image.attached?
        image_tag teddy_type.image.variant(resize_to_fill: [100, 100]).processed
      end
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
  filter :on_sale
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :teddy_name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :category, as: :select, collection: Category.all.collect { |category| [category.category_name, category.id] }
      f.input :on_sale
      f.input :image, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      row :teddy_name
      row :description
      row :price
      row :stock_quantity
      row :on_sale
      row :category
      row "Image" do
        if teddy_type.image.attached?
          image_tag teddy_type.image.variant(resize_to_fill: [300, 300]).processed
        end
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
