class ProposalsController < ApplicationController
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
end
