# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false
      t.string :email, null: false
      t.integer :zip, null: false
      t.string :prefecture, null: false
      t.string :municipality, null: false
      t.string :street, null: false
      t.string :name_on_card, null: false
      t.integer :credit_cart_number, null: false
      t.string :expiration, null: false
      t.integer :cvv, null: false
      t.integer :billing_amount, null: false

      t.timestamps
    end
  end
end
