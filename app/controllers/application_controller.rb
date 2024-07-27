# frozen_string_literal: true

# ApplicationController is the base controller for all other controllers in the application.
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart
  helper ApplicationHelper

  private

  def set_cart
    @cart = current_cart
  end

  def current_cart
    return unless user_signed_in?

    @current_cart ||= Cart.find_or_create_by(customer_id: current_user.id)
  end

  protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :street, :city, :province, :postal_code, :phone_number])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :street, :city, :province, :postal_code, :phone_number])
  end
end
