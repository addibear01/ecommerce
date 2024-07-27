# frozen_string_literal: true

# Migration to create the categories table with category_name column.
class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false

      t.timestamps
    end
  end
end
