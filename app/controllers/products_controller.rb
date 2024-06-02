# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.where.not(id: @product.id).order(created_at: :desc).limit(4).with_attached_image
  end

  def new; end

  def edit; end
end
