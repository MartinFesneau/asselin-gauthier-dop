class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def index_clips
    @clips = Project.where(category: "clip")
  end

end
