class AddDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_status, :string unless column_exists?(:orders, :payment_status)
    add_column :orders, :payment_id, :string unless column_exists?(:orders, :payment_id)
    add_column :orders, :customer_id, :integer unless column_exists?(:orders, :customer_id)
    add_column :orders, :status, :string unless column_exists?(:orders, :status)
    add_column :orders, :total_amount, :decimal unless column_exists?(:orders, :total_amount)
  end
end
