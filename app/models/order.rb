class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :order_taxes, dependent: :destroy

  validates :street, :city, :province, :postal_code, presence: true

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
    logger.debug "Calculating taxes for order #{id} in province #{province} with subtotal #{subtotal}"

    case province
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
    ["id", "user_id", "created_at", "updated_at", "total_amount", "street", "city", "province", "postal_code", "payment_status", "payment_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "order_items", "order_taxes"]
  end

  scope :recent, ->(limit) { order(created_at: :desc).limit(limit) }
end
