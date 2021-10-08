class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.create!(params.require(:project).permit(
                                 :title, :description, :max_per_hour, :deadline, :place
                               ))
    redirect_to root_path
  end
end
