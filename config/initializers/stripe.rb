Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
puts "Stripe API Key: #{Stripe.api_key.inspect}" # Debug statement
