# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @order = Order.new(params_purchase_info)
    if @order.save
      flash[:notice] = '購入ありがとうございます。'
      redirect_to root_path
    else
      @cart_items = current_cart.cart_items_load
      @total = current_cart.total_price
      flash[:notice] = '購入できませんでした。'
      render '/carts/show', status: :unprocessable_entity
    end
  end

  private

  def params_purchase_info
    params.require(:order).permit(:last_name, :first_name, :username, :email, :zip, :prefecture, :municipality,
                                  :street, :name_on_card, :credit_cart_number, :expiration, :cvv)
  end
end
