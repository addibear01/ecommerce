# frozen_string_literal: true

# Migration to add foreign key for province to users table.
class AddForeignKeyToUsersProvince < ActiveRecord::Migration[7.0]
  def change
    # Ensure there is no duplicate column error by checking if the column exists
    if column_exists?(:users, :province_id)
      add_foreign_key :users, :provinces, column: :province_id
    else
      add_reference :users, :province, foreign_key: true
    end
  end
end
