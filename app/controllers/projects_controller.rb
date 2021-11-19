class ProjectsController < ApplicationController
  before_action :authenticate_employer!, only: %i[create new suspend finished avaliable]
  before_action :authenticate_both!, only: %i[search feedback]
  before_action :authenticate_perfil, only: :show

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(
                             :title, :description, :max_per_hour, :deadline, :place
                           ))
    @project.employer = current_employer
    if @project.save
      flash[:notice] = 'Projeto salvo'
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
    @proposal = Proposal.new
    @worker_proposal = Proposal.where('project_id = ? AND worker_id = ?', @project, current_worker) if worker_signed_in?
    @employer_proposals = if @project.suspend?
                            @project.proposals.select(&:accepted?)
                          else
                            @project.proposals.reject(&:rejected?).reject(&:canceled?)
                          end
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
    redirect_to(@project.proposals.blank? ? root_path : feedback_project_path)
  end

  def feedback
    @project = Project.find(params[:id])
    @workers = @project.proposals.select(&:accepted?).map(&:worker)
    @feedback_worker = FeedbackWorker.new
    @feedback_employer = FeedbackEmployer.new
  end

  def search
    @query = params[:query].force_encoding('UTF-8')
    @projects = Project.where("title LIKE ? OR description LIKE ?", '%' + @query + '%', '%' + @query + '%')
  end

  def avaliable
    @project = Project.find(params[:id])
    @project.avaliable!
    flash[:notice] = 'Projeto disponível'
    redirect_to project_path(@project)
  end
end
