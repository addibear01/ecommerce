# frozen_string_literal: true

# Migration to add on_sale field to teddy_types table.
class AddOnSaleToTeddyTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :teddy_types, :on_sale, :boolean
  end
end
