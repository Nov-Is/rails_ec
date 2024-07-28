# frozen_string_literal: true

class AddBillingAmountToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :billing_amount, :integer, null: false, default: 0
  end
end
