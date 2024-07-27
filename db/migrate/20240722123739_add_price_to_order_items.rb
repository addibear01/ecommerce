# frozen_string_literal: true

# Migration to add price field to order_items table.
class AddPriceToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :price, :decimal unless column_exists?(:order_items, :price)
  end
end
