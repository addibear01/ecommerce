# frozen_string_literal: true

# Migration to create the users table for Devise authentication.
class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_users_table
    add_indexes
  end

  private

  def create_users_table
    create_table :users do |table|
      table.string :email, null: false, default: ''
      table.string :encrypted_password, null: false, default: ''

      add_recoverable_fields(table)
      add_rememberable_fields(table)
      add_address_and_province(table)

      table.timestamps null: false
    end
  end

  def add_recoverable_fields(table)
    table.string :reset_password_token
    table.datetime :reset_password_sent_at
  end

  def add_rememberable_fields(table)
    table.datetime :remember_created_at
  end

  def add_address_and_province(table)
    table.string :address
    table.references :province, foreign_key: true, null: false, default: 1
  end

  def add_indexes
    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
