# frozen_string_literal: true

require 'rails_helper'

describe 'Worker register proposal' do
  it 'succefully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    create(:perfil_worker, worker: worker)
    create(:project, title: 'Site de freelancer', description: 'Site para contratar freelancers')
    mailer_spy = class_spy(ProposalMailer)
    stub_const('ProposalMailer', mailer_spy)
    mail = double
    allow(ProposalMailer)
      .to receive(:notify_new_proposal).and_return(mail)
    allow(mail).to receive(:deliver_now)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Descrição da proposta', with: 'texto justificando a proposta'
    fill_in 'Valor da hora', with: 7.0
    fill_in 'Horas disponíveis por semana', with: 20
    fill_in 'Expectativa de conclusão', with: 4.days.from_now
    click_on 'Enviar'

    expect(ProposalMailer).to have_received(:notify_new_proposal)
    expect(mail).to have_received(:deliver_now)
    expect(page).to have_content('Proposta enviada')
    expect(page).to have_content('Cancelar a proposta')
    expect(page).not_to have_content('Justifique o cancelamento')
    expect(page).to have_content('Site para contratar freelancers')
  end
  context 'validations' do
    it ' cannot in a suspend project' do
      worker = Worker.create!(email: 'email@email.com', password: '123456')
      project = create(:project, title: 'Site de freelancer', status: :suspend)
      create(:perfil_worker, worker: worker)

      login_as worker, scope: :worker
      visit project_path(project)
      expect(page).to have_content('Site de freelancer')
      expect(page).not_to have_content('Digite uma proposta')
    end

    it 'cannot in a finished a project' do
      worker = Worker.create!(email: 'email@email.com', password: '123456')
      project = create(:project, title: 'Site de freelancer', status: :finished)
      create(:perfil_worker, worker: worker)

      login_as worker, scope: :worker
      visit project_path(project)
      expect(page).to have_content('Site de freelancer')
      expect(page).not_to have_content('Digite uma proposta')
    end

    it 'cannot create a proposal blank' do
      worker = Worker.create!(email: 'email@email.com', password: '123456')
      create(:perfil_worker, worker: worker)
      create(:project, title: 'Site de freelancer', description: 'Site para contratar freelancers')

      login_as worker, scope: :worker
      visit root_path
      click_on 'Site de freelancer'
      fill_in 'Descrição da proposta', with: ''
      fill_in 'Valor da hora', with: ''
      fill_in 'Horas disponíveis por semana', with: ''
      fill_in 'Expectativa de conclusão', with: ''
      click_on 'Enviar'

      expect(page).not_to have_content('Proposta enviada')
      expect(page).not_to have_content('Cancelar proposta')
      expect(page).to have_content('não pode ficar em branco')
      expect(page).to have_content('Site para contratar freelancers')
    end
  end
end
