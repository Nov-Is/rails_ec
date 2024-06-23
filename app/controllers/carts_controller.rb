# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :setup_cart_item!, only: %i[create]

  def show
    @cart_items = current_cart.cart_items.eager_load(:product)
    @total = @cart_items.inject(0) { |sum, product| sum + product.sum_of_price }
  end

  def create
    @cart_item = current_cart.cart_items.new(product_id: params[:product_id]) if @cart_item.blank?
    @cart_item.quantity += 1
    if @cart_item.quantity <= @cart_item.product.stock
      @cart_item.save
      flash[:notice] = "商品「#{@cart_item.product.name}」をカートに追加しました。"
    else
      flash[:notice] = "商品「#{@cart_item.product.name}」をカートに追加できません。"
    end
    redirect_to root_path
  end

  private

  def setup_cart_item!
    @cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
  end
end
