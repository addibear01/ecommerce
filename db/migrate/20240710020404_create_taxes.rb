# frozen_string_literal: true

# Migration to create the taxes table with province, tax_type, and tax_rate columns.
class CreateTaxes < ActiveRecord::Migration[6.1]
  def change
    create_table :taxes do |t|
      t.string :province
      t.string :tax_type
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
