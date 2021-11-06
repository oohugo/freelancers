class ProposalMailer < ApplicationMailer
  def notify_new_proposal
    @proposal = params[:proposal]
    mail(to: @proposal.employer.email, subject: 'Nova proposta para seu projeto')
  end
end
