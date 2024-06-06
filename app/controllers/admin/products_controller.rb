# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    def index
      @products = Product.with_attached_image
    end

    def new; end

    def edit; end
  end
end
