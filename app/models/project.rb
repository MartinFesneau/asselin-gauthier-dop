class Project < ApplicationRecord
  validates :url, presence: true  
  # validates :name, :artist, :director, :producer
  has_many_attached :photos
end
