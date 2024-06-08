# frozen_string_literal: true

class ChangeDatatypeProducts < ActiveRecord::Migration[7.0]
  def up
    change_column :products, :name, :string, null: false, limit: 20
  end

  def down
    change_column :products, :name, :string, null: false
  end
end
