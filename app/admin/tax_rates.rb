# frozen_string_literal: true

# TaxRate management in ActiveAdmin.
ActiveAdmin.register TaxRate do
  permit_params :province, :gst, :pst, :hst

  form do |f|
    f.inputs do
      f.input :province
      f.input :gst
      f.input :pst
      f.input :hst
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :province
    column :gst
    column :pst
    column :hst
    actions
  end
end
