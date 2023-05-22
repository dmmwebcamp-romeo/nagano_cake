class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def subtotal
    item.with_tax_price * quantity
  end

  def total_price
    cart_item.subtotal.sum
  end


end
