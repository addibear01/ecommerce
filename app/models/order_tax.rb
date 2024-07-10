class OrderTax < ApplicationRecord
  belongs_to :order
  belongs_to :tax

  # Validations
  validates :order_id, presence: true
  validates :tax_id, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
