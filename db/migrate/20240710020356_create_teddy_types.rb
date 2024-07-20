class CreateTeddyTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :teddy_types do |t|
      t.string :teddy_name, null: false
      t.text :description, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :stock_quantity, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
