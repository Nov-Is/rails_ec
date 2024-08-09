# frozen_string_literal: true

class Order < ApplicationRecord
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :username, presence: true
  validates :email, presence: true
  validates :zip, presence: true
  validates :prefecture, presence: true
  validates :municipality, presence: true
  validates :street, presence: true
  validates :name_on_card, presence: true
  validates :credit_cart_number, presence: true
  validates :expiration, presence: true
  validates :cvv, presence: true

  has_one :promotion_code, dependent: :destroy
end
