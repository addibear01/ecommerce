class Customer < ApplicationRecord
  has_many :orders
  has_many :carts

  # Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, length: { maximum: 15 }
  validates :province, presence: true, length: { maximum: 50 }
end
