# frozen_string_literal: true

# Migration to create the provinces table with a name column.
class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
