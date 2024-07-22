class Cart < ApplicationRecord
  belongs_to :customer, class_name: 'User'
  has_many :cart_items, dependent: :destroy
  has_many :teddy_types, through: :cart_items

  def add_teddy_type(teddy_type)
    current_item = cart_items.find_by(teddy_type_id: teddy_type.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(teddy_type_id: teddy_type.id)
    end
    current_item.save
  end

  def remove_teddy_type(teddy_type)
    current_item = cart_items.find_by(teddy_type_id: teddy_type.id)
    if current_item
      current_item.quantity -= 1
      current_item.save
      current_item.destroy if current_item.quantity <= 0
    end
  end

  def clear
    cart_items.destroy_all
  end
end
