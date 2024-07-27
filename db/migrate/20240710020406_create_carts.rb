# frozen_string_literal: true

# Migration to create the carts table with a reference to customers.
class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.references :customer, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
