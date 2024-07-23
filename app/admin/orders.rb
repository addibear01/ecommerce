ActiveAdmin.register Order do
  controller do
    def find_resource
      Order.includes(:order_items, :order_taxes).find(params[:id])
    end
  end
  # Filter settings for Ransack
  filter :user
  filter :created_at
  filter :updated_at
  filter :total_amount
  filter :street
  filter :city
  filter :province
  filter :postal_code
  filter :payment_status
  filter :payment_id

  index do
    selectable_column
    id_column
    column :user
    column :created_at
    column :total_amount do |order|
      number_to_currency(order.total_amount)
    end
    column :payment_status
    column :payment_id
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
      row :payment_status
      row :payment_id
    end

    panel "Order Items" do
      table_for order.order_items do
        column :teddy_type
        column :quantity
        column :price
      end
    end

    panel "Taxes" do
      table_for order.calculate_taxes.to_a do
        column :tax_name do |tax|
          tax[0].to_s.upcase
        end
        column :tax_amount do |tax|
          number_to_currency(tax[1])
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
