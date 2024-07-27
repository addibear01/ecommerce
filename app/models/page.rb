# frozen_string_literal: true

# Page represents a static page in the application.
class Page < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  before_validation :generate_slug

  private

  def generate_slug
    self.slug ||= title.parameterize if title
  end

  private_class_method def self.ransackable_attributes(_auth_object = nil)
    %w[id title content slug created_at updated_at]
  end
end
