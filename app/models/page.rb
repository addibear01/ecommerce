class Page < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  before_validation :generate_slug

  private

  def generate_slug
    self.slug ||= title.parameterize if title
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "content", "slug", "created_at", "updated_at"]
  end
end
