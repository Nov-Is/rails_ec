# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @order = Order.new(params_purchase_info)
    @cart_items = current_cart.cart_items_load
    @total = current_cart.total_price
    if @order.save
      ApplicationRecord.transaction do
        # カートから商品を一つずつ取り出して処理
        @cart_items.each do |cart_item|
          @order_details = order_create(cart_item, @order.id)
          product = Product.find(cart_item.product_id)
          inventory_processing(product, cart_item.quantity)
        end
        @cart.destroy
        session.delete(:cart_id)
      end
      OrderMailer.order_confirmation(@order).deliver_now
      flash[:notice] = '購入ありがとうございます。'
      redirect_to root_path
    else
      flash[:notice] = '購入できませんでした。'
      render '/carts/show', status: :unprocessable_entity
    end
  end

  private

  def params_purchase_info
    params.require(:order).permit(:last_name, :first_name, :username, :email, :zip, :prefecture, :municipality,
                                  :street, :name_on_card, :credit_cart_number, :expiration, :cvv)
  end

  # cart_itemをdbに保存
  def order_create(cart_item, order_id)
    OrderDetail.create(product_name: cart_item.product.name, price: cart_item.product.price,
                       quantity: cart_item.quantity, order_id:)
  end

  # 在庫処理
  def inventory_processing(product, cart_item_quantity)
    raise '在庫不足です。' unless product.stock >= cart_item_quantity

    product.stock -= cart_item_quantity
    product.update(stock: product.stock)
  end
end
