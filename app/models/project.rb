class Project < ApplicationRecord
  validates :url, presence: true  
  validates :name, presence: true  
  validates :artist, presence: true  
  validates :director, presence: true  
  validates :producer, presence: true  
  validates :category, presence: true
  has_many_attached :photos
end
