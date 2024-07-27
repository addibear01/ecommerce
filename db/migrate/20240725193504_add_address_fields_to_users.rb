class AddAddressFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :street, :string unless column_exists?(:users, :street)
    add_column :users, :city, :string unless column_exists?(:users, :city)
    add_column :users, :province, :string unless column_exists?(:users, :province)
    add_column :users, :postal_code, :string unless column_exists?(:users, :postal_code)
    add_column :users, :phone_number, :string unless column_exists?(:users, :phone_number)
  end
end
