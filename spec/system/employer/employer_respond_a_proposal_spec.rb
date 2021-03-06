require 'rails_helper'

describe 'Employer respond a proposal' do
  it 'accepting' do
    employer = create(:employer)
    project = create(:project, title: 'Site de freelancer', employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: create(:worker))

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Aceitar Proposta'

    expect(page).to have_content('Sou bom em fazer sites')
    expect(page).to have_content('Proposta aceita', count: 2)
    expect(page).not_to have_content('Status: Proposta pendente')
    expect(page).not_to have_content('Aceitar Proposta')
  end
  it 'reject' do
    employer = create(:employer)
    date = 4.days.from_now.to_date
    project = create(:project, title: 'Site de freelancer', employer: employer)
    proposal = Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                                hours_per_week: 20, date_close: date,
                                project: project, worker: create(:worker))

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    find_link('Rejeitar Proposta', href: "#{proposal_path(proposal)}/rejected").click

    expect(page).to have_content('Sou bom em fazer sites')
    expect(page).to have_content('Valor da hora: R$ 7,00')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content("Expectativa de conclusão: #{I18n.l(date)}")
    expect(page).to have_content('Proposta rejeitada', count: 2)
    expect(page).not_to have_content('Rejeitar Proposta')
    expect(page).not_to have_content('Status: Proposta pendente')
    expect(page).not_to have_content('Status: Proposta aceita')
    expect(page).not_to have_content('Aceitar Proposta')
  end
end
