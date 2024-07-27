# frozen_string_literal: true

# Migration to create the orders table with references to customers and order attributes.
class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.boolean :status
      t.decimal :total_amount

      t.timestamps
    end
  end
end
