class ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  
  def index 
    if params[:category].present?
      @projects = Project.where(category: params[:category]).order(:position)
    else
      @projects = Project.all.order(:position)
    end
  end

  def new
    @project = Project.new
  end

  def create
    @projects = Project.all
    @project = Project.new(project_params)
    @project.position = @projects.length + 1
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end


  def move_project
    project = Project.find(params[:id])
    new_position = params[:position].to_i
    Project.change_position(project, new_position)
  end

  def show
    @project = Project.friendly.find(params[:id])
    @project.url = Project.urlify(@project.url) unless @project.url = ""
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