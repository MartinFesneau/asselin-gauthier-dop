class Project < ApplicationRecord
  FORMAT = ["21by9", "16by9", "4by3", "1by1"]
  validates :url, presence: true  
  validates :name, presence: true  
  validates :artist, presence: true  
  validates :director, presence: true  
  validates :producer, presence: true  
  validates :format, presence: true
  validates :category, presence: true
  has_many_attached :photos

  extend FriendlyId
  friendly_id :name, use: :slugged
end

