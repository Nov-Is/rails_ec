# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_one :promotion_code, dependent: :destroy

  def cart_items_load
    cart_items.eager_load(:product)
  end

  def total_price
    cart_items_load.inject(0) { |sum, product| sum + product.sum_of_price }
  end
end
