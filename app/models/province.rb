# frozen_string_literal: true

# Province represents a province in the application.
class Province < ApplicationRecord
  has_many :users
  has_many :orders
  
  validates :name, presence: true
end
