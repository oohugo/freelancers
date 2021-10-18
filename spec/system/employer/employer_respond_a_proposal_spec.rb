require 'rails_helper'

describe 'Employer respond a proposal' do
  it 'accepting' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote', employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Aceitar proposta'

    expect(page).to have_content('Sou bom em fazer sites')
    expect(page).to have_content('Proposta aceita')
    expect(page).to have_content('Status: accepted')
    expect(page).not_to have_content('Aceitar proposta')
  end
  it 'reject' do
    joao = Worker.create!(email: 'joao@email.com', password: '123456')
    maria = Worker.create!(email: 'maria@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    date = 4.days.from_now.to_date
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote', employer: employer)
    proposal_joao = Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                                     hours_per_week: 20, date_close: date,
                                     project: project, worker: joao)
    Proposal.create!(description: 'Especialista em webdesenvolvimento', hourly_value: 6.0,
                     hours_per_week: 25, date_close: 3.days.from_now,
                     project: project, worker: maria)

    login_as employer, scope: :employer

    visit root_path
    click_on 'Site de freelancer'
    find_link('Rejeitar proposta', href: "#{proposal_path(proposal_joao)}/rejected").click

    expect(page).not_to have_content('Sou bom em fazer sites')
    expect(page).not_to have_content('Valor por hora: R$ 7,00')
    expect(page).not_to have_content('Horas disponíveis por semana: 20')
    expect(page).not_to have_content("Previsão de conclusão: #{date}")
    expect(page).to have_content('Proposta rejeitada')
    expect(page).to have_content('Especialista em webdesenvolvimento')
    expect(page).to have_content('R$ 6,00')
    expect(page).to have_content('25')
  end
end
