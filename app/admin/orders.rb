ActiveAdmin.register Order do
  # Filter settings for Ransack
  filter :user
  filter :created_at
  filter :updated_at
  filter :total_amount
  filter :street
  filter :city
  filter :province
  filter :postal_code

  index do
    selectable_column
    id_column
    column :user
    column :created_at
    column :total_amount do |order|
      number_to_currency(order.total_amount)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :created_at
      row :updated_at
      row :total_amount do
        number_to_currency(order.total_amount)
      end

      panel "Order Items" do
        table_for order.order_items do
          column :teddy_type
          column :quantity
          column :price
        end
      end

      panel "Taxes" do
        table_for order.calculate_taxes do
          column :tax_name do |tax|
            tax[0]
          end
          column :tax_amount do |tax|
            number_to_currency(tax[1])
          end
        end
      end
    end

    active_admin_comments
  end

  sidebar :help do
    ul do
      li link_to "Orders Report", admin_orders_report_path
    end
  end
end
