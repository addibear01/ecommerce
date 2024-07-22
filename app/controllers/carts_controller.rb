class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_cart
  end

  def add_item
    @cart = current_cart
    teddy_type = TeddyType.find(params[:teddy_type_id])
    @cart.add_teddy_type(teddy_type)

    redirect_to cart_path(@cart)
  end

  def remove_item
    @cart = current_cart
    teddy_type = TeddyType.find(params[:teddy_type_id])
    @cart.remove_teddy_type(teddy_type)

    redirect_to cart_path(@cart)
  end

  def update_item
    @cart = current_cart
    cart_item = @cart.cart_items.find(params[:cart_item_id])
    cart_item.update(quantity: params[:quantity])

    redirect_to cart_path(@cart)
  end
end
