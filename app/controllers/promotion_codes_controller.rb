# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  def update
    promotion_code = PromotionCode.find_by(promotion_code: params[:cart][:promotion_code])
    if promotion_code.cart_id.present?
      flash[:notice] = 'このコードは使用されています。'
      redirect_to cart_path(current_cart)
      return
    end

    if promotion_code&.available
      flash[:notice] = 'プロモーションコードを適用しました。'
      current_cart
      promotion_code.update!(cart_id: @cart.id)
    else
      flash[:notice] = 'このコードは使用できません。'
    end
    redirect_to cart_path(current_cart)
  end
end
