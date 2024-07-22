ActiveAdmin.register_page "Dashboard" do
  content do
    panel "Recent Orders" do
      ul do
        Order.recent(5).map do |order|
          li link_to("Order ##{order.id}", admin_order_path(order))
        end
      end
    end

    panel "Reports" do
      ul do
        li link_to("Orders Report", admin_orders_report_path)
      end
    end
  end
end
