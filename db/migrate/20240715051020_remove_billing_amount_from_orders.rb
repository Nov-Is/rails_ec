# frozen_string_literal: true

class RemoveBillingAmountFromOrders < ActiveRecord::Migration[7.0]
  def up
    remove_column :orders, :billing_amount, :integer
  end

  def down
    add_column :orders, :billing_amount, :integer
  end
end
