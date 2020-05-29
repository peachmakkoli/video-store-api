class Video < ApplicationRecord
  validates :title, :overview, :release_date, :total_inventory, :available_inventory, presence: true
  validates :available_inventory, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  
  has_many :rentals, dependent: :nullify # if a video is destroyed, the video_id on associated rentals will be set to nil
  has_many :customers, through: :rentals
end
