# frozen_string_literal: true

# Migration to create the order_taxes table with references to orders and taxes.
class CreateOrderTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :order_taxes do |t|
      t.references :order, foreign_key: true
      t.references :tax, foreign_key: true
      t.decimal :tax_amount

      t.timestamps
    end
  end
end
