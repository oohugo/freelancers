class ProposalsController < ApplicationController
  before_action :authenticate_employer!, only: %i[accepted rejected]
  before_action :authenticate_worker!, only: %i[create canceled]
  def create
    @proposal = Proposal.new(params.require(:proposal)
                               .permit(:description, :hourly_value,
                                       :hours_per_week, :date_close))
    @proposal.project = Project.find(params[:project_id])
    @proposal.worker = current_worker
    @proposal.save!
    flash[:notice] = 'Proposta enviada'
    redirect_to @proposal.project
  end

  def accepted
    @proposal = Proposal.find(params[:id])
    @proposal.accepted!
    flash[:notice] = 'Proposta aceita'
    redirect_to @proposal.project
  end

  def rejected
    @proposal = Proposal.find(params[:id])
    @proposal.rejected!
    flash[:notice] = 'Proposta rejeitada'
    redirect_to @proposal.project
  end

  def canceled
  end
end
