# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default from: ENV['g_user_name']

  def order_confirmation(order)
    @order = order
    @items = OrderDetail.items(@order.id)
    @promotion_code = PromotionCode.applied(@order.id)
    mail(
      subject: 'ご購入ありがとうございます。',
      to: @order.email
    )
  end
end
