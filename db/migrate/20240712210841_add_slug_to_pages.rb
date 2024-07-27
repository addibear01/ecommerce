# frozen_string_literal: true

# Migration to add slug column to the pages table.
class AddSlugToPages < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :slug, :string
  end
end
