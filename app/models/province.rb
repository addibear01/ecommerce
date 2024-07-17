class Province < ApplicationRecord
  has_many :users
  has_many :addresses

  validates :name, presence: true
end
