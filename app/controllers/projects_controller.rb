class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(
                             :title, :description, :max_per_hour, :deadline, :place
                           ))
    @project.employer = current_employer
    if @project.save
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
    @worker_proposal = Proposal.where('project_id = ? AND worker_id = ?', @project, current_worker) if worker_signed_in?
  end
end
