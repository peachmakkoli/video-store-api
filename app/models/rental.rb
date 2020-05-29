class Rental < ApplicationRecord
  validates :customer_id, :video_id, presence: true
  
  belongs_to :customer
  belongs_to :video

  # checkout method
  def self.check_out(customer_id, video_id)
    Customer.increment_counter(:videos_checked_out_count, customer_id, touch: true)
    Video.decrement_counter(:available_inventory, video_id, touch: true)
  end
end
