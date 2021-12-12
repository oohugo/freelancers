class ProjectsController < ApplicationController
  before_action :authenticate_employer!, only: %i[create new suspend finished avaliable]
  before_action :authenticate_both!, only: %i[search feedback]
  before_action :authenticate_perfil, only: :show
  before_action :set_project, only: %i[avaliable show suspend finished feedback]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params_project)
    @project.employer = current_employer
    if @project.save
      flash[:notice] = t('.success')
      redirect_to root_path
    else
      render action: 'new'
    end
  end

  def show
    @proposal = Proposal.new
    @worker_proposal = Proposal.where('project_id = ? AND worker_id = ?', @project, current_worker) if worker_signed_in?
    @employer_proposals = if @project.suspend?
                            @project.proposals.accepted
                          else
                            @project.proposals.reject(&:rejected?).reject(&:canceled?)
                          end
    @employer_proposals_archive = @project.proposals.select { |proposal| proposal.rejected? || proposal.canceled? }
  end

  def suspend
    @project.suspend!
    flash[:notice] = t('.success')
    redirect_to @project
  end

  def finished
    @project.finished!
    flash[:notice] = t('.success')
    redirect_to(@project.proposals.blank? ? root_path : feedback_project_path)
  end

  def feedback
    @workers = @project.proposals.select(&:accepted?).map(&:worker) if employer_signed_in?
    @feedback = Feedback.new
  end

  def search
    @query = params[:query].force_encoding('UTF-8')
    @projects = Project.where("title LIKE ? OR description LIKE ?", '%' + @query + '%', '%' + @query + '%')
  end

  def avaliable
    @project.avaliable!
    flash[:notice] = t('.success')
    redirect_to project_path(@project)
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def params_project
    params.require(:project).permit(
      :title, :description, :max_per_hour, :deadline, :place
    )
  end
end
