# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, length: { maximum: 20 }, presence: true
  validates :price, numericality: { greater_than: 0, only_integer: true }, presence: true
  validates :stock, numericality: { greater_than: 0, only_integer: true }, presence: true
  validates :description, presence: true
  validates :image, presence: true

  has_one_attached :image
end
