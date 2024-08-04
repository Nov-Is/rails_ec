# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  def update
    @promo_code = PromotionCode.find_by(promotion_code: params[:promotion_code][:promotion_code])
    if @promo_code&.available
      flash[:notice] = 'プロモーションコードを適用しました。'
      redirect_to cart_path(p_code_id: @promo_code.id)
    else
      flash[:notice] = 'このコードは使用できません。'
      redirect_to cart_path
    end
  end

  private

  def promo_code_params
    params.require(:promotion_code).permit(:promotion_code)
  end
end
