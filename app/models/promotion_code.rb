# frozen_string_literal: true

class PromotionCode < ApplicationRecord
  belongs_to :order
end
