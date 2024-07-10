class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :teddy_type, null: false, foreign_key: true
      t.integer :quantity
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
