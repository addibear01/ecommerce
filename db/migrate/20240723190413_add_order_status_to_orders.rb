# frozen_string_literal: true

# Migration to add order_status field to orders table with a default value.
class AddOrderStatusToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :order_status, :integer, default: 0
  end
end
