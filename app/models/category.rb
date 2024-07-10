class Category < ApplicationRecord
  has_many :teddy_types

  # Validations
  validates :category_name, presence: true, uniqueness: true, length: { maximum: 50 }
end
