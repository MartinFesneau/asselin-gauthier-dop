class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index_clips]

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


  private 

  def project_params
    params.require(:project).permit(
      :category, :url, :artist, :name, 
      :director, :producer, photos: []
    )
  end
end