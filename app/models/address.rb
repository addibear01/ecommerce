class Address < ApplicationRecord
  belongs_to :user
  belongs_to :province

  validates :street, presence: true
  validates :city, presence: true
  validates :province_id, presence: true
  validates :postal_code, presence: true
end
