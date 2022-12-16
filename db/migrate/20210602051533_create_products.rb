# frozen_string_literal: true

# creating products table
class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku, index: true
      t.text :image_urls, array: true, default: []
      t.string :name
      t.string :price

      t.timestamps
    end
  end
end
