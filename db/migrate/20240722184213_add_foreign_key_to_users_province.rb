class AddForeignKeyToUsersProvince < ActiveRecord::Migration[7.0]
  def change
    # Ensure there is no duplicate column error by checking if the column exists
    unless column_exists?(:users, :province_id)
      add_reference :users, :province, foreign_key: true
    else
      add_foreign_key :users, :provinces, column: :province_id
    end
  end
end
