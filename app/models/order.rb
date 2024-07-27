class Order < ApplicationRecord
  belongs_to :user
  belongs_to :province, optional: true
  has_many :order_items, dependent: :destroy

  validates :street, :city, :province_id, :postal_code, presence: true
  validates :postal_code, length: { maximum: 10 }

  enum order_status: { created: 0, pending: 0, processed: 1, shipped: 2 }
  enum payment_status: { unpaid: 0, paid: 1, refunded: 2 }

  PROVINCES = ['Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan', 'Northwest Territories', 'Nunavut', 'Yukon']

  def total_amount
    subtotal + total_taxes
  end

  def subtotal
    order_items.sum { |item| item.price * item.quantity }
  end

  def total_taxes
    calculate_taxes.values.sum
  end

  def calculate_taxes
    return { gst: subtotal * 0.05 } unless province

    case province.name
    when 'Alberta', 'Northwest Territories', 'Nunavut', 'Yukon'
      { gst: subtotal * 0.05 }
    when 'British Columbia'
      { gst: subtotal * 0.05, pst: subtotal * 0.07 }
    when 'Manitoba'
      { gst: subtotal * 0.05, pst: subtotal * 0.07 }
    when 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Prince Edward Island'
      { hst: subtotal * 0.15 }
    when 'Ontario'
      { hst: subtotal * 0.13 }
    when 'Quebec'
      { gst: subtotal * 0.05, qst: subtotal * 0.09975 }
    when 'Saskatchewan'
      { gst: subtotal * 0.05, pst: subtotal * 0.06 }
    else
      { gst: subtotal * 0.05 }
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ["order_status"]
  end

  def self.ransackable_associations(auth_object = nil)
    super + ["user", "order_items"]
  end

  scope :recent, ->(limit) { order(created_at: :desc).limit(limit) }
end
