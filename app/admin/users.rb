ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :email
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end

    panel "Orders" do
      table_for user.orders do
        column :id
        column :created_at
        column :total_amount
        column("Details") { |order| link_to "View", admin_order_path(order) }
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
