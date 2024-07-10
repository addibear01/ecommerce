class TeddyType < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items

  # Validations
  validates :teddy_name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true
end
