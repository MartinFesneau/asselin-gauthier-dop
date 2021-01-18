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

  def index 
    if params[:category].present?
      @projects = Project.where(category: params[:category])
    else
      @projects = Project.all
    end
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
    @project.delete
    redirect_to projects_path
  end
  
  private 

  def project_params
    params.require(:project).permit(
      :category, :format , :url, :artist, :name, 
      :director, :producer, photos: []
    )
  end
end