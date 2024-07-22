class OrdersController < ApplicationController
  def new
    @order = Order.new
    @user = current_user
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      if current_cart.cart_items.present?
        current_cart.cart_items.each do |cart_item|
          teddy_type = cart_item.teddy_type
          @order.order_items.create(teddy_type: teddy_type, quantity: cart_item.quantity, price: teddy_type.price)
        end
        current_cart.clear
        redirect_to @order, notice: 'Order was successfully created.'
      else
        @order.destroy
        redirect_to new_order_path, alert: 'Your cart is empty. Please add items to the cart before completing the order.'
      end
    else
      Rails.logger.debug "Order save failed: #{@order.errors.full_messages.join(", ")}"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
    @taxes = @order.calculate_taxes
  end

  private

  def order_params
    params.require(:order).permit(:street, :city, :province, :postal_code)
  end
end
