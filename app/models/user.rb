class User < ApplicationRecord
  belongs_to :province
  has_many :addresses

  # Devise modules and validations remain the same
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
end
