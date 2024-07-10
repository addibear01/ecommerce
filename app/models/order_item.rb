class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :teddy_type
end
