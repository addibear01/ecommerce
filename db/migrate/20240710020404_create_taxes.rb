class CreateTaxes < ActiveRecord::Migration[7.1]
  def change
    create_table :taxes do |t|
      t.string :province
      t.string :tax_type
      t.decimal :tax_rate
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
