# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  def self.applied(params_id)
    find_by(order_id: params_id)
  end
end
