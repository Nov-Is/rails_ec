# frozen_string_literal: true

class OrdersController < ApplicationController
  def create
    @cart_items = current_cart.cart_items_load
    @total = current_cart.total_price
    @order = Order.new(params_purchase_info)
    discount_amount = params[:p_code_id] ? caluculate_discount(params[:p_code_id]) : 0
    @order.billing_amount = @total - discount_amount
    if ApplicationRecord.transaction do
         @order.save!
         process_items_one_by_one
         update_promotion_code
         delete_cart_and_session
       end
      OrderMailer.order_confirmation(@order).deliver_now
      redirect_to root_path, notice: '購入ありがとうございます。'
    else
      else_process
    end
  end

  private

  def params_purchase_info
    params.require(:order).permit(:last_name, :first_name, :username, :email, :zip, :prefecture, :municipality,
                                  :street, :name_on_card, :credit_cart_number, :expiration, :cvv, :p_code_id)
  end

  # 割引額の計算
  def caluculate_discount(p_code_id)
    PromotionCode.find(p_code_id) ? PromotionCode.find(p_code_id).discount_amount : 0
  end

  # カートから商品を一つずつ取り出して処理
  def process_items_one_by_one
    @cart_items.each do |cart_item|
      @order_details = order_create(cart_item, @order.id)
      product = Product.find(cart_item.product_id)
      raise '在庫不足です。' unless product.stock >= cart_item.quantity

      inventory_processing(product, cart_item.quantity)
    end
  end

  # cart_itemをdbに保存
  def order_create(cart_item, order_id)
    @order_detail = OrderDetail.create!(product_name: cart_item.product.name, price: cart_item.product.price,
                                        quantity: cart_item.quantity, order_id:)
  end

  # 在庫処理
  def inventory_processing(product, cart_item_quantity)
    product.stock -= cart_item_quantity
    product.update!(stock: product.stock)
  end

  # プロモーションコードにorder_id、使用済みに変更
  def update_promotion_code
    return unless params[:p_code_id]

    PromotionCode.find(params[:p_code_id]).update(order_id: @order.id, available: false)
  end

  # カート及びセッション削除
  def delete_cart_and_session
    remove_instance_variable :@cart
    session.delete(:cart_id)
  end

  def else_process
    flash[:notice] = '購入できませんでした。'
    redirect_to '/carts/show', status: :unprocessable_entity
  end
end
