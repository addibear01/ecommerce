class AddOnSaleToTeddyTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :teddy_types, :on_sale, :boolean
  end
end
