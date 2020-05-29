class Rental < ApplicationRecord
  validates :customer_id, :video_id, presence: true
  
  belongs_to :customer
  belongs_to :video

  def check_in
    Customer.decrement_counter(:videos_checked_out_count, customer_id, touch: true)
    Video.increment_counter(:available_inventory, video_id, touch: true)
    self.update(due_date: nil)
  end
end
