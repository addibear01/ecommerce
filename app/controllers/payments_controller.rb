class PaymentsController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 500 # Example amount in cents, adjust as needed

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )

    # Assuming you have an Order model and order_id is passed in the params
    order = Order.find(params[:order_id])
    order.update(payment_status: 'paid', payment_id: charge.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
