class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :teddy_type

  # Validations
  validates :cart_id, presence: true
  validates :teddy_type_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
