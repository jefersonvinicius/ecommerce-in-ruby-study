class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def total
    self.product.price * self.quantity 
  end
end
  