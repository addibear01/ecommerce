class OrdersController < ApplicationController
  def new
    @order = Order.new
    @user = current_user
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user  # Associate the order with the current user

    Rails.logger.debug "Order Params: #{order_params.inspect}"
    Rails.logger.debug "Order Valid? #{@order.valid?}"
    Rails.logger.debug "Order Errors: #{@order.errors.full_messages.join(", ")}" unless @order.valid?

    if @order.save
      Rails.logger.debug "Order saved successfully"
      session[:cart].each do |teddy_type_id, quantity|
        teddy_type = TeddyType.find(teddy_type_id)
        @order.order_items.create(teddy_type: teddy_type, quantity: quantity, price: teddy_type.price)
      end
      session[:cart] = {}
      redirect_to @order, notice: 'Order was successfully created.'
    else
      Rails.logger.debug "Order save failed: #{@order.errors.full_messages.join(", ")}"
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @taxes = calculate_taxes(@order)
  end

  private

  def order_params
    params.require(:order).permit(:street, :city, :province, :postal_code)
  end

  def calculate_taxes(order)
    case order.province
    when 'Alberta', 'Northwest Territories', 'Nunavut', 'Yukon'
      { gst: 0.05, pst: 0.00 }
    when 'British Columbia'
      { gst: 0.05, pst: 0.07 }
    when 'Manitoba'
      { gst: 0.05, pst: 0.07 }
    when 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Prince Edward Island'
      { hst: 0.15 }
    when 'Ontario'
      { hst: 0.13 }
    when 'Quebec'
      { gst: 0.05, pst: 0.09975 }
    when 'Saskatchewan'
      { gst: 0.05, pst: 0.06 }
    else
      { gst: 0.05 }
    end
  end
end
