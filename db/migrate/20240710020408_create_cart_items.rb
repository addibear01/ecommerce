class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true
      t.references :teddy_type, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
