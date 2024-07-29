# frozen_string_literal: true

class OrderDetailsController < ApplicationController
  before_action :basic_auth
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @items = OrderDetail.where(order_id: params[:id])
  end
end
