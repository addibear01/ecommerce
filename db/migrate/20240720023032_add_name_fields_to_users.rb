# frozen_string_literal: true

# Migration to add first_name and last_name fields to users table.
class AddNameFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
