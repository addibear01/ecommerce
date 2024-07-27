# frozen_string_literal: true

# Migration to create the pages table with title and content columns.
class CreatePages < ActiveRecord::Migration[7.1]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
