class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.boolean :status
      t.decimal :total_amount
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
