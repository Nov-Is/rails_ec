# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @cart_items = current_cart.cart_items_load
    @total = current_cart.total_price
    @order = Order.new(params_purchase_info)
    @order.billing_amount = @cart.promotion_code.present? ? @total - @cart.promotion_code.discount_amount : @total

    total_valid = true
    ApplicationRecord.transaction do
      total_valid &= @order.save
      total_valid &= process_items_one_by_one
      total_valid &= update_promotion_code
      raise ActiveRecord::Rollback unless total_valid
    end
    if total_valid
      delete_cart_and_session
      send_mail(@order)
    else
      else_process
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
    product.stock -= cart_item_quantity
    product.update(stock: product.stock)
  end

  # カートから商品を一つずつ取り出して処理
  def process_items_one_by_one
    all_valid = true
    @cart_items.each do |cart_item|
      @order_details = order_create(cart_item, @order.id)
      product = Product.find(cart_item.product_id)
      all_valid &= product.stock >= cart_item.quantity
      inventory_processing(product, cart_item.quantity)
    end
    all_valid
  end

  # プロモーションコードにorder_id、使用済みに変更
  def update_promotion_code
    return true if @cart.promotion_code.blank?

    PromotionCode.find(@cart.promotion_code.id).update!(order_id: @order.id, available: false)
  end

  # カート及びセッション削除
  def delete_cart_and_session
    remove_instance_variable :@cart
    session.delete(:cart_id)
  end

  # メール送信
  def send_mail(order)
    OrderMailer.order_confirmation(order).deliver_now
    redirect_to root_path, notice: '購入ありがとうございます。'
  end

  # else処理
  def else_process
    current_cart
    flash[:notice] = '購入できませんでした。'
    render '/carts/show', status: :unprocessable_entity
  end
end
