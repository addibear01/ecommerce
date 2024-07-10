class Category < ApplicationRecord
  has_many :teddy_types

  # Validations
  validates :category_name, presence: true, uniqueness: true, length: { maximum: 50 }

  def self.ransackable_attributes(auth_object = nil)
    ["id", "category_name", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["teddy_types"]
  end
end
