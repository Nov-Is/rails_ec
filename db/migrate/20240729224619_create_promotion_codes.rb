# frozen_string_literal: true

class CreatePromotionCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :promotion_codes do |t|
      t.string :promotion_code, null: false
      t.integer :discount_amount, null: false
      t.boolean :available, null: false
      t.references :cart, foreign_key: true, index: { unique: true }
      t.references :order, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
