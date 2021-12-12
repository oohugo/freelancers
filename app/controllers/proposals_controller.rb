class ProposalsController < ApplicationController
  before_action :authenticate_employer!, only: %i[accepted rejected]
  before_action :authenticate_worker!, only: %i[create cancel]
  before_action :project_avaliable!, only: :create
  before_action :set_proposal, only: %i[accepted rejected cancel]

  def create
    project = Project.find(params[:project_id])
    @proposal = current_worker.proposals.new(params.require(:proposal)
                              .permit(:description, :hourly_value, :hours_per_week, :date_close))
    @proposal.project = project
    salving_proposal
    redirect_to @proposal.project
  end

  def accepted
    @proposal.accepted!
    @proposal.date_accepted = Time.zone.today
    flash[:notice] = 'Proposta aceita'
    redirect_to @proposal.project
  end

  def rejected
    @proposal.rejected!
    flash[:notice] = 'Proposta rejeitada'
    redirect_to @proposal.project
  end

  def cancel
    @proposal.comment = params[:comment] if params.key? :comment
    if @proposal.save
      @proposal.canceled!
      flash[:notice] = 'Proposta cancelada'
    end
    redirect_to @proposal.project
  end

  private

  def project_avaliable!
    project = Project.find(params[:project_id])
    return unless project.suspend? || project.finished?

    redirect_to project
  end

  def salving_proposal
    if @proposal.save
      flash[:notice] = 'Proposta enviada'
      ProposalMailer.with(proposal: @proposal).notify_new_proposal.deliver_now
    else
      flash[:alert] = @proposal.errors.full_messages.first
    end
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
