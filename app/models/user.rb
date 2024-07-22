class User < ApplicationRecord
  belongs_to :province
  has_one :cart, foreign_key: 'customer_id'
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, length: { maximum: 15 }
  validates :province_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "first_name", "id", "last_name", "phone_number", "province_id", "sign_in_count", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders"]
  end
end
