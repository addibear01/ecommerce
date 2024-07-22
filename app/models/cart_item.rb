class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :teddy_type

  # Validations
  validates :cart_id, presence: true
  validates :teddy_type_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  def product
    teddy_type
  end
  def increment_quantity
    self.quantity += 1
  end

  def serialize
    { 'teddy_type_id' => teddy_type_id, 'quantity' => quantity }
  end

  def self.from_hash(item_data)
    new(teddy_type_id: item_data['teddy_type_id'], quantity: item_data['quantity'])
  end
end
