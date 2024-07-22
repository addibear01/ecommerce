ActiveAdmin.register Order do
  permit_params :street, :city, :province, :postal_code, order_items_attributes: [:id, :teddy_type_id, :quantity, :price, :_destroy]

  index do
    selectable_column
    id_column
    column :user
    column :created_at
    column :total_amount
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :created_at
      row :street
      row :city
      row :province
      row :postal_code
      row :total_amount
    end

    panel "Order Items" do
      table_for order.order_items do
        column :teddy_type
        column :quantity
        column :price
      end
    end

    panel "Taxes" do
      order.calculate_taxes.each do |tax_name, tax_amount|
        row tax_name do
          number_to_currency(tax_amount)
        end
      end
    end
  end
end
