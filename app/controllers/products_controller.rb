# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image
  end

  def show; end

  def new; end

  def edit; end
end
