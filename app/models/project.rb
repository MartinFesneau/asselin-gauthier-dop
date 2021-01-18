class Project < ApplicationRecord
  FORMAT = ["21by9", "16by9", "4by3", "1by1"]
  CATEGORY = ["clip", "pub"]
  validates :url, presence: true  
  validates :name, presence: true  
  validates :artist, presence: true  
  validates :director, presence: true  
  validates :producer, presence: true  
  validates :format, presence: true
  validates :category, presence: true
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :filer_by_category,
    against: [:category],
  using: {
    tsearch: { prefix: true }
}

  extend FriendlyId
  friendly_id :name, use: :slugged


  class << Project
    def regexpify(url)
      # delete the channel part of the youtube url if necessary, maybe possible to do it in the regexp
      if url.include?"&"
        index = url.index("&")
        url.slice!(index..-1)
      end
      # regexp to identify the source (youtube or vimeo) and the video id
      regexp = /(\A.{11}.(?<source>[a-z]*).*=(?<youtube_id>.*)|\A.{5}:\/\/.{9}\/(?<vimeo_id>.*))/
      match_data = url.strip.match(regexp)
    end
    
    def extract_source(url)
      match_data = regexpify(url)
      source = match_data[:source]
    end
    
    def extract_id(url)
      match_data = regexpify(url)
      source = extract_source(url)
      source == "youtube" ? video_id = match_data[:youtube_id] : video_id = match_data[:vimeo_id]
    end
    
    def urlify(url)
      # create the good embed url for the video
      source = extract_source(url)
      video_id = extract_id(url)
      if source == "youtube"
        url = "https://www.youtube.com/embed/#{video_id}"
      else
        url = "https://player.vimeo.com/video/#{video_id}"
      end
    end
  end
end

