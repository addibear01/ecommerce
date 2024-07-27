class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    teddy_type = TeddyType.find(params[:teddy_type_id])
    @cart.add_teddy_type(teddy_type)
    redirect_to cart_path, notice: 'Item added to cart.'
  end

  def update
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.update(quantity: params[:quantity])
    redirect_to cart_path, notice: 'Cart updated.'
  end

  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: 'Item removed from cart.'
  end

  private

  def set_cart
    @cart = current_cart
  end
end
