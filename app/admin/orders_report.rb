ActiveAdmin.register_page "OrdersReport" do
  content do
    panel "Orders Report" do
      table_for Order.includes(:user, :order_items).all do
        column :id
        column :user
        column :created_at
        column :total_amount do |order|
          number_to_currency(order.total_amount)
        end
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
        column "Order Status" do |order|
          status_tag(order.order_status)
        end
        # Removed the problematic "Actions" column
      end
    end
  end

  # Removing the action item and member action as well
  # action_item :ship_order, only: :show do
  #   link_to 'Mark as Shipped', mark_as_shipped_admin_order_path(order), method: :put if order.paid?
  # end

  # member_action :mark_as_shipped, method: :put do
  #   resource.update(order_status: :shipped)
  #   redirect_to resource_path, notice: "Order marked as shipped."
  # end
end
