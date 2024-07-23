class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
    @taxes = @order.calculate_taxes
    logger.debug "Order taxes: #{@taxes}"
  end

  def new
    @order = Order.new
    @user = current_user
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.order_status = :pending

    if @order.save
      if current_cart.cart_items.present?
        total_amount = current_cart.cart_items.sum { |cart_item| cart_item.quantity * cart_item.teddy_type.price }
        @order.update(total_amount: total_amount)

        current_cart.cart_items.each do |cart_item|
          teddy_type = cart_item.teddy_type
          @order.order_items.create(teddy_type: teddy_type, quantity: cart_item.quantity, price: teddy_type.price)
        end

        begin
          Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
          amount = (@order.total_amount * 100).to_i

          customer = Stripe::Customer.create(
            email: current_user.email,
            source: params[:stripeToken]
          )

          charge = Stripe::Charge.create(
            customer: customer.id,
            amount: amount,
            description: 'Rails Stripe customer',
            currency: 'usd'
          )

          @order.update(payment_status: 'paid', payment_id: charge.id, order_status: :paid)
          current_cart.clear
          redirect_to @order, notice: 'Order was successfully created and paid.'
        rescue Stripe::CardError => e
          @order.destroy
          flash[:error] = e.message
          render :new, status: :unprocessable_entity
        end
      else
        @order.destroy
        redirect_to new_order_path, alert: 'Your cart is empty. Please add items to the cart before completing the order.'
      end
    else
      Rails.logger.debug "Order save failed: #{@order.errors.full_messages.join(", ")}"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:street, :city, :province, :postal_code)
  end
end
