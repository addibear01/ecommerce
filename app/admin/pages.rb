# frozen_string_literal: true

# Page management in ActiveAdmin.
ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  index do
    selectable_column
    id_column
    column :title
    column :slug
    column :created_at
    column :updated_at
    actions
  end

  filter :title
  filter :slug
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :slug
      f.input :content, as: :text
    end
    f.actions
  end
end
