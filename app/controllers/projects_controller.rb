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
    @project = Project.friendly.find(params[:id])
    @project.url = Project.urlify(@project.url)
  end

  def edit
    @project = Project.friendly.find(params[:id])
  end
  
  def update
    @project = Project.friendly.find(params[:id])
    @project.update(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def destroy
    @project = Project.friendly.find(params[:id])
    clip = @project.category == "clip"
    @project.delete
    if clip
      redirect_to music_videos_path
    else
      redirect_to commercials_path
    end
  end
  
  private 

  def project_params
    params.require(:project).permit(
      :category, :format , :url, :artist, :name, 
      :director, :producer, photos: []
    )
  end
end