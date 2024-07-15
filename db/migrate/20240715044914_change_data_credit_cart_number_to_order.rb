# frozen_string_literal: true

class ChangeDataCreditCartNumberToOrder < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :credit_cart_number, :bigint
  end

  def down
    change_column :orders, :credit_cart_number, :integer
  end
end
