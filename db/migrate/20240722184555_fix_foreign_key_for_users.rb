class FixForeignKeyForUsers < ActiveRecord::Migration[7.0]
  def change
    # Remove the incorrect foreign key
    remove_foreign_key :users, column: :province_id if foreign_key_exists?(:users, column: :province_id, primary_key: "name")

    # Ensure no duplicate foreign key
    remove_foreign_key :users, :provinces if foreign_key_exists?(:users, :provinces)

    # Add the correct foreign key
    add_foreign_key :users, :provinces, column: :province_id
  end
end
