ActiveAdmin.register Category do
  permit_params :category_name

  index do
    selectable_column
    id_column
    column :category_name
    actions
  end

  filter :category_name

  form do |f|
    f.inputs do
      f.input :category_name
    end
    f.actions
  end
end