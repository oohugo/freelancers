class ProjectsController < ApplicationController
  before_action :authenticate_employer!, only: %i[create new suspend finished]

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
    if worker_signed_in?
      if current_worker.perfil_worker.nil?
        flash[:alert] = 'É necessário criar perfil para ver projetos'
        redirect_to new_perfil_worker_path
      else
        @worker_proposal = Proposal.where('project_id = ? AND worker_id = ?', @project, current_worker)
      end
    end
    @employer_proposals = @project.suspend? ? @project.proposals.select(&:accepted?) : @project.proposals.reject(&:rejected?)
  end

  def suspend
    @project = Project.find(params[:id])
    @project.suspend!
    flash[:notice] = 'Propostas suspensas'
    redirect_to @project
  end

  def finished
    @project = Project.find(params[:id])
    @project.finished!
    flash[:notice] = 'Projeto finalizado'
    redirect_to feedback_project_path
  end

  def feedback
    @project = Project.find(params[:id])
    @workers = @project.proposals.select(&:accepted?).map(&:worker)
    @feedback_worker = FeedbackWorker.new
    @feedback_employer = FeedbackEmployer.new
  end
end
