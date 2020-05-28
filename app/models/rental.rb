class Rental < ApplicationRecord
  validates :customer_id, :video_id, presence: true
  
  belongs_to :customer
  belongs_to :video
end
