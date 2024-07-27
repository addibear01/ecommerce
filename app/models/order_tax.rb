# frozen_string_literal: true

# OrderTax represents a tax associated with an order.
class OrderTax < ApplicationRecord
  belongs_to :order
  belongs_to :tax

  # Validations
  validates :order_id, presence: true
  validates :tax_id, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id tax_amount tax_type updated_at order_id]
  end
end
