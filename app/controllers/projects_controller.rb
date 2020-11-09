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
    @project.video_id = extract_id(@project.url)
  end

  private 

  def project_params
    params.require(:project).permit(
      :category, :url, :artist, :name, 
      :director, :producer, photos: []
    )
  end

  def extract_id(url)
    source_regexp = /(\A.{5}:\/\/w{3}.(?<source>[a-z]*).*=(?<youtube_id>.*)|\A.{5}:\/\/.{9}\/(?<vimeo_id>.*))/
    match_data = url.strip.match(source_regexp)
    match_data[:source] == "youtube" ? video_id = match_data[:youtube_id] : video_id = match_data[:vimeo_id]
  end
end