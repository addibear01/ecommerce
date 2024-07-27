# frozen_string_literal: true

# Migration to add user_id reference to orders table.
class AddUserIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :user, foreign_key: true
  end
end
