# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def cart_items_load
    cart_items.eager_load(:product)
  end
end
