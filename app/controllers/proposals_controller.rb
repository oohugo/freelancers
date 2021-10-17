class ProposalsController < ApplicationController
  before_action :authenticate_employer!, only: %i[accepted rejected]
  before_action :authenticate_worker!, only: %i[create cancel]
  def create
    project = Project.find(params[:project_id])
    if project.suspend? || project.finished?
      redirect_to project
      return
    end
    @proposal = Proposal.new(params.require(:proposal)
                               .permit(:description, :hourly_value, :hours_per_week, :date_close))
    @proposal.project = project
    @proposal.worker = current_worker
    @proposal.save ? flash[:notice] = 'Proposta enviada' : flash[:alert] = @proposal.errors.full_messages.first
    redirect_to @proposal.project
  end

  def accepted
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    @proposal.date_accepted = Date.today
    flash[:notice] = 'Proposta aceita'
    redirect_to @proposal.project
  end

  def rejected
    @proposal = Proposal.find(params[:id])
    @proposal.rejected!
    flash[:notice] = 'Proposta rejeitada'
    redirect_to @proposal.project
  end

  def cancel
    @proposal = Proposal.find(params[:id])
    @proposal.canceled!
    flash[:notice] = 'Proposta cancelada'
    redirect_to @proposal.project
  end

  def cancel_with_justification
    @proposal = Proposal.find(params[:id])
    @proposal.comment = params[:comment]
    if @proposal.save
      @proposal.canceled!
      flash[:notice] = 'Proposta cancelada'
    else
      flash[:alert] = @proposal.errors.full_messages.first
    end
    redirect_to @proposal.project
  end
end
