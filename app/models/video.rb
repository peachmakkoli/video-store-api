class Video < ApplicationRecord
  validates :title, :overview, :release_date, presence: true
  validates :available_inventory, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  
  has_many :rentals
  has_many :customers, through: :rentals
end
