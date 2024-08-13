# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :order

  scope :items, ->(params_id) { where(order_id: params_id) }
end
