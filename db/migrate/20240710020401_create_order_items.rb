class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :teddy_type, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :item_price
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
