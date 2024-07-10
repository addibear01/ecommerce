class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :teddy_type
end
