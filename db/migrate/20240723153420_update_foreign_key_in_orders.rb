class UpdateForeignKeyInOrders < ActiveRecord::Migration[6.0]
  def change
    # Ensure the foreign key references users instead of customers
    remove_foreign_key :orders, column: :customer_id if foreign_key_exists?(:orders, :customer_id)
    add_foreign_key :orders, :users, column: :user_id
  end
end
