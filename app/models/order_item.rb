class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :teddy_type

  validates :order_id, presence: true
  validates :teddy_type_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def subtotal
    quantity * price
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "order_id", "price", "quantity", "teddy_type_id", "updated_at"]
  end
end
