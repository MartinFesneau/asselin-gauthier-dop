class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index_clips, :show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save && @project.category == "clip"
      redirect_to musicvideos_path
    elsif @project.save && @project.category == "pub"
      redirect_to musicvideos_path
    else
      render :new
    end
  end

  def index_clips
    @clips = Project.where(category: "clip").reverse
  end

  def show
    @project = Project.find(params[:id])
    @project.url = urlify(@project.url)
  end

  private 

  def project_params
    params.require(:project).permit(
      :category, :format , :url, :artist, :name, 
      :director, :producer, photos: []
    )
  end

  def regexpify(url)
    regexp = /(\A.{11}.(?<source>[a-z]*).*=(?<youtube_id>.*)&|\A.{5}:\/\/.{9}\/(?<vimeo_id>.*))/
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
    source = extract_source(url)
    video_id = extract_id(url)
    if source == "youtube"
      url = "https://www.youtube.com/embed/#{video_id}"
    else
      url = "https://player.vimeo.com/video/#{video_id}"
    end
  end
end