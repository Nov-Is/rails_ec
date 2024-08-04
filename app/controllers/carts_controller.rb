# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_product_id, :setup_cart_item!, only: %i[create destroy]

  def show
    @cart_items = current_cart.cart_items_load
    @total = current_cart.total_price
    @order = Order.new
    @promotion_code = (PromotionCode.find(params[:p_code_id]) if params[:p_code_id])
  end

  def create
    @cart_item = current_cart.cart_items.new(product_id: @product_id) if @cart_item.blank?
    @cart_item.quantity += params[:quantity].to_i
    if @cart_item.quantity <= @cart_item.product.stock
      @cart_item.save
      flash[:notice] = "商品「#{@cart_item.product.name}」をカートに追加しました。"
    else
      flash[:notice] = "商品「#{@cart_item.product.name}」をカートに追加できません。"
    end
    redirect_to root_path
  end

  def destroy
    @cart_item.destroy
    flash[:notice] = "カートから商品「#{@cart_item.product.name}」を削除しました。"
    redirect_to cart_path(@cart_item.cart_id)
  end

  private

  # index,showからの受取値を整形
  def set_product_id
    @product_id = (params[:product_id] || params[:format])
  end

  def setup_cart_item!
    @cart_item = current_cart.cart_items.find_by(product_id: @product_id)
  end
end
