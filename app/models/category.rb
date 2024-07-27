# frozen_string_literal: true

# Category represents a product category in the e-commerce application.
class Category < ApplicationRecord
  has_many :teddy_types, dependent: :destroy

  validates :category_name, presence: true, uniqueness: true, length: { maximum: 50 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id category_name created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['teddy_types']
  end
end
