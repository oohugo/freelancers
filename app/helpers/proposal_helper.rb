module ProposalHelper
  def can_worker_make_proposal?(project)
    project.avaliable? && current_worker.proposals.all { |proposal| !proposal.rejected? || !proposal.canceled? }
  end
end
