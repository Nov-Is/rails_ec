# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :basic_auth

    def index
      @products = Product.order(created_at: :asc).with_attached_image
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

    def edit
      @product = Product.find(params[:id])
    end

    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        flash[:notice] = "商品「#{@product.name}」を更新しました。"
        redirect_to admin_products_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      product = Product.find(params[:id])
      product.destroy
      flash[:notice] = "商品「#{product.name}」を削除しました。"
      redirect_to admin_products_path
    end

    private

    def product_params
      params.require(:product).permit(:name, :price, :stock, :description, :image)
    end
  end
end
