# app/models/user.rb
class User < ApplicationRecord
  belongs_to :province, optional: true
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  after_create :create_cart

  # Validations
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :street, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 50 }
  validates :province_id, presence: true
  validates :postal_code, presence: true, length: { maximum: 10 }
  validates :phone_number, presence: true, length: { maximum: 15 }

  def self.ransackable_attributes(auth_object = nil)
    %w[id first_name last_name email created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[province cart orders]
  end

  private

  def create_cart
    Cart.create(user: self)
  end
end
