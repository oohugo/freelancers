class ProposalMailerPreview < ActionMailer::Preview
  def notify_new_proposal
    proposal = FactoryBot.create(:proposal)
    ProposalMailer.with(proposal: proposal).notify_new_proposay
  end
end
