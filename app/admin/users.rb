# frozen_string_literal: true

# User management in ActiveAdmin.
ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :created_at
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :created_at

  form partial: 'admin/users/form'

  show partial: 'admin/users/show'
end
