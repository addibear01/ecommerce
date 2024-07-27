# frozen_string_literal: true

# Helper methods for rendering order items and taxes list
def render_order_items_list(order)
  ul do
    order.order_items.each do |item|
      li "#{item.teddy_type.teddy_name} - Quantity: #{item.quantity}"
    end
  end
end

def render_taxes_list(order)
  ul do
    order.calculate_taxes.each do |tax_name, tax_amount|
      li "#{tax_name.upcase}: #{number_to_currency(tax_amount)}"
    end
  end
end

# OrdersReport page configuration in ActiveAdmin.
ActiveAdmin.register_page 'OrdersReport' do
  content do
    panel 'Orders Report' do
      table_for Order.includes(:user, :order_items).all do
        column :id
        column :user
        column :created_at
        column :total_amount
        column 'Products Ordered' do |order|
          render_order_items_list(order)
        end
        column 'Taxes' do |order|
          render_taxes_list(order)
        end
        column 'Grand Total' do |order|
          number_to_currency(order.total_amount)
        end
        column 'Order Status' do |order|
          status_tag(order.order_status)
        end
        column 'Actions' do |order|
          if order.paid?
            link_to('Mark as Shipped', mark_as_shipped_admin_orders_report_path(order), method: :put, data: { confirm: 'Are you sure?' }) +
            link_to('Mark as Delivered', mark_as_delivered_admin_orders_report_path(order), method: :put, data: { confirm: 'Are you sure?' })
          elsif order.shipped?
            link_to('Mark as Delivered', mark_as_delivered_admin_orders_report_path(order), method: :put, data: { confirm: 'Are you sure?' })
          end
        end
      end
    end
  end

  controller do
    def mark_as_shipped
      order = Order.find(params[:id])
      order.update(order_status: :shipped)
      redirect_to admin_orders_report_path, notice: 'Order marked as shipped.'
    end

    def mark_as_delivered
      order = Order.find(params[:id])
      order.update(order_status: :delivered)
      redirect_to admin_orders_report_path, notice: 'Order marked as delivered.'
    end
  end

  def create
    begin
      customer = Stripe::Customer.create(
        email: current_user.email,
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: (current_order.total_amount * 100).to_i, # Amount in cents
        description: 'Order payment',
        currency: 'usd',
        billing_details: {
          name: params[:billing_name],
          address: {
            line1: params[:billing_address],
            city: params[:billing_city],
            state: params[:billing_state],
            postal_code: params[:billing_zip],
            country: params[:billing_country]
          }
        }
      )

      if charge.paid
        current_order.update(payment_status: :paid, order_status: :paid)
        redirect_to success_path, notice: "Payment successful and order status updated."
      else
        redirect_to failure_path, alert: "Payment failed. Please try again."
      end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  end
end
