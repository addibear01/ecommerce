# frozen_string_literal: true

# Migration to add payment details fields to orders table.
class AddPaymentDetailsToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :payment_status, :string unless column_exists?(:orders, :payment_status)
    add_column :orders, :payment_id, :string unless column_exists?(:orders, :payment_id)
  end
end
