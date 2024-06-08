# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth

    def index
      @products = Product.with_attached_image
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        flash[:notice] = "商品「#{@product.name}」を登録しました。"
        redirect_to admin_products_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    private

    def product_params
      params.require(:product).permit(:name, :price, :stock, :description, :image)
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == 'admin' && password == 'pw'
      end
    end
  end
end
