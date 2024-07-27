class AddUserIdToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :user_id, :integer
    add_index :carts, :user_id
    add_reference :carts, :customer, foreign_key: { to_table: :users }
  end
end
