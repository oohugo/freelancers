require 'rails_helper'

RSpec.describe ProposalMailer, type: :mailer do
  context 'new proposal' do
    it 'should notify employer' do
      john = Employer.create!(email: 'john@doe.com.br', password: '123456')
      john_project = create(:project, title: 'Site de freelancers', employer: john)
      maria = Worker.create!(email: 'maria@email.com.br', password: '123456')
      proposal = create(:proposal, worker: maria, project: john_project)

      mail = ProposalMailer.with(proposal: proposal).notify_new_proposal

      expect(mail.to).to eq ['john@doe.com.br']
      expect(mail.from).to eq ['nao-responda@freelancers.com.br']
      expect(mail.subject).to eq 'Nova proposta para seu projeto'
      expect(mail.body).to include "Seu projeto 'Site de freelancers' recebeu uma proposta de maria@email.com.br"
    end
  end
end
