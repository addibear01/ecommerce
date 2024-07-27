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
  end

  def create
    Rails.logger.debug "Complete parameters: #{params.inspect}"
    Rails.logger.debug "Order parameters before require: #{params[:order].inspect}"

    begin
      order_permitted_params = order_params
      Rails.logger.debug "Order parameters after permit: #{order_permitted_params.inspect}"
    rescue ActionController::ParameterMissing => e
      Rails.logger.error "Parameter missing error: #{e.message}"
      @order = Order.new
      render :new, status: :unprocessable_entity
      return
    end

    @order = Order.new(order_permitted_params)
    @order.user = current_user
    @order.payment_status = 'unpaid' # Set the initial payment status to 'unpaid'
    @order.order_status = 'created'      # Set the initial order status to 'new'

    Rails.logger.debug "Order attributes before save: #{@order.attributes.inspect}"

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

          payment_intent = Stripe::PaymentIntent.create(
            amount: amount,
            currency: 'usd',
            payment_method_types: ['card'],
            description: 'Order payment for Mirror Teddies'
          )

          @order.update(payment_id: payment_intent.id)
          current_cart.clear
          redirect_to new_payment_path(payment_intent_id: payment_intent.id), notice: 'Order was successfully created. Please complete the payment.'
        rescue Stripe::StripeError => e
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
    params.require(:order).permit(:street, :city, :province_id, :postal_code)
  end
end
