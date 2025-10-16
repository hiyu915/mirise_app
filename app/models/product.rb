class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end