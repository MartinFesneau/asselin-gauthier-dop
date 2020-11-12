class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index_clips, :index_commercials, :show]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def index_clips
    @clips = Project.where(category: "clip").reverse
  end

  def index_commercials
    @commercials = Project.where(category: "pub").reverse
  end

  def show
    @project = Project.find(params[:id])
    @project.url = urlify(@project.url)
  end

  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:id])
    clip = @project.category == "clip"
    @project.delete
    clip ? redirect_to music_videos_path : redirect_to commercials_path
  end
  
  private 

  def project_params
    params.require(:project).permit(
      :category, :format , :url, :artist, :name, 
      :director, :producer, photos: []
    )
  end

  def regexpify(url)
    if url.include?"&"
      index = url.index("&")
      url.slice!(index..-1)
    end
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
    source = extract_source(url)
    video_id = extract_id(url)
    if source == "youtube"
      url = "https://www.youtube.com/embed/#{video_id}"
    else
      url = "https://player.vimeo.com/video/#{video_id}"
    end
  end
end