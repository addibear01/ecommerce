class CreateTeddyTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :teddy_types do |t|
      t.string :teddy_name
      t.text :description
      t.decimal :price
      t.integer :stock_quantity
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
