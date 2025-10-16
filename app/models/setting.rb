class Setting < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :price, numericality: true
  validates :pos_numbers, presence: true
end