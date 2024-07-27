# frozen_string_literal: true

# Migration to fix the foreign key for province in users table.
class FixForeignKeyForUsers < ActiveRecord::Migration[6.1]
  def change
    if foreign_key_exists?(:users, column: :province_id, primary_key: 'name')
      remove_foreign_key :users, column: :province_id
    end

    remove_foreign_key :users, :provinces if foreign_key_exists?(:users, :provinces)
    add_foreign_key :users, :provinces, column: :province_id
  end
end
