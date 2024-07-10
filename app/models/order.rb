class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items
  has_many :order_taxes

  # Validations
  validates :customer_id, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
