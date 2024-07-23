class TeddyType < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items
  has_one_attached :image

  # Validations
  validates :teddy_name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :category_id, presence: true

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "price", "stock_quantity", "teddy_name", "updated_at", "on_sale"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category", "order_items", "cart_items"]
  end

  def thumbnail
    image.variant(resize: "100x100").processed
  end

  def display_image
    image.variant(resize: "300x300").processed
  end
end
