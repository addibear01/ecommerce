class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    # Retrieve the event by verifying the signature using the raw body and Stripe signature header
    payload = request.body.read
    sig_header = request.headers['Stripe-Signature']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      Rails.logger.error "JSON parsing error: #{e.message}"
      head :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error "Signature verification error: #{e.message}"
      head :bad_request
      return
    end

    # Handle the event
    case event['type']
    when 'payment_intent.succeeded'
      payment_intent = event['data']['object']
      order = Order.find_by(payment_id: payment_intent['id'])
      if order && order.payment_status == 'unpaid'
        order.update(payment_status: 'paid', order_status: 'paid') # Update order status as needed
      end
    else
      Rails.logger.info "Unhandled event type: #{event['type']}"
    end

    head :ok
  end
end
