class Project < ApplicationRecord
  FORMAT = ["21by9", "16by9", "4by3", "1by1"]
  CATEGORY = ["clip", "pub", 'narrative']
  validates :name, presence: true  
  validates :artist, presence: true  
  validates :format, presence: true
  validates :category, presence: true
  has_many_attached :photos

  extend FriendlyId
  friendly_id :name, use: :slugged


  class << Project

    def change_position(project, new_position)
      return if project.position == new_position
      new_position += 1 if new_position > project.position
      projects = Project.where("position >= ?", new_position).order(:position)
      projects.update_all("position = position + 1")
      project.update(position: new_position)
      fix_positions_for_column(project)
    end

    def fix_positions_for_column(project)
      projects = Project.order(:position)
                  .select("id, position, ROW_NUMBER() OVER(ORDER BY position) AS new_position")
                  .to_sql
      query = <<~SQL
        UPDATE projects AS before
        SET position = new_position
        FROM (#{projects}) AS after
        WHERE before.id = after.id;
      SQL
      ActiveRecord::Base.connection.execute(query)
    end

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

