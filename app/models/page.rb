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

  def self.ransackable_attributes(auth_object = nil)
    %w[title content created_at slug]
  end

  def self.ransackable_associations(auth_object = nil)
    []  # Add associations if needed
  end
end
