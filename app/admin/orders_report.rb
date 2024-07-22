ActiveAdmin.register_page "OrdersReport" do
  content do
    panel "Orders Report" do
      table_for Order.includes(:user, :order_items).all do
        column :id
        column :user
        column :created_at
        column :total_amount
        column "Products Ordered" do |order|
          ul do
            order.order_items.each do |item|
              li "#{item.teddy_type.teddy_name} - Quantity: #{item.quantity}"
            end
          end
        end
        column "Taxes" do |order|
          ul do
            order.calculate_taxes.each do |tax_name, tax_amount|
              li "#{tax_name.upcase}: #{number_to_currency(tax_amount)}"
            end
          end
        end
        column "Grand Total" do |order|
          number_to_currency(order.total_amount)
        end
      end
    end
  end

  # Commented out or removed the sidebar render call
  # sidebar :filters, only: :index do
  #   render "admin/orders/filters"
  # end
end
