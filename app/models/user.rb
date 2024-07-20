class User < ApplicationRecord
  belongs_to :province
  has_one :cart, foreign_key: 'customer_id'
  has_many :orders

  # Devise modules and validations remain the same
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true, length: { maximum: 255 }
  validates :phone_number, presence: true, length: { maximum: 15 }
  validates :province, presence: true, length: { maximum: 50 }
end
