# frozen_string_literal: true

# model for products table
class Product < ApplicationRecord
  validates :sku, presence: true, uniqueness: true
end
