class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(
                             :title, :description, :max_per_hour, :deadline, :place
                           ))
    if @project.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end
end
