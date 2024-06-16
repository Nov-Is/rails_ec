# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    if session[:cart_id]
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
