class Project < ApplicationRecord
  validates :type, :url, :name, :artist, :director, :producer
  has_many_attached :photos
end
