class Tax < ApplicationRecord
  has_many :order_taxes

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :percentage, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
