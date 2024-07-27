# frozen_string_literal: true

# Migration to add phone_number field to users table.
class AddPhoneNumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone_number, :string
  end
end
