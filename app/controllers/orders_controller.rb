class OrdersController < ApplicationController
  def new
    @order = Order.new
    @user = current_user
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user  # Associate the order with the current user

    if @order.save
      session[:cart].each do |product_id, quantity|
        product = Product.find(product_id)
        @order.order_items.create(product: product, quantity: quantity, price: product.price)
      end
      session[:cart] = {}
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @taxes = calculate_taxes(@order)
  end

  private

  def order_params
    params.require(:order).permit(:total_amount, :status, :street, :city, :province, :postal_code)
  end

  def calculate_taxes(order)
    case order.province
    when 'ON'
      { pst: 0.08, gst: 0.05, hst: 0.13 }
    when 'QC'
      { pst: 0.09975, gst: 0.05 }
    else
      { gst: 0.05 }
    end
  end
end
