class CreateTeddyTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :teddy_types do |t|
      t.string :teddy_name
      t.text :description
      t.decimal :price
      t.integer :stock_quantity
      t.references :category, null: false, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
