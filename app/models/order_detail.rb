# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :order

  scope :order_id, ->(params_id) { where(order_id: params_id) }
end
