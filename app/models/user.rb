class User < ApplicationRecord
  belongs_to :province

  # Devise modules and validations remain the same
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  validates :address, presence: true
  validates :province_id, presence: true
end
