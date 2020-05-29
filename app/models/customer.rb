class Customer < ApplicationRecord
  validates :videos_checked_out_count, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  has_many :rentals, dependent: :nullify # if a customer is destroyed, the customer_id on associated rentals will be set to nil
  has_many :videos, through: :rentals
end
