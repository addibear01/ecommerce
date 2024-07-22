class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :teddy_type, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
