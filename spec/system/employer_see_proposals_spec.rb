require 'rails_helper'

describe 'Employer see proposal' do
  it 'succefully' do
    employer = Employer.create!(email: 'joao@email.com', password: '123456')
    worker = Worker.create!(email: 'worker@email.com', password: '123456')
    site = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                           max_per_hour: 10.0, deadline: 5.days.from_now, place: 'Remoto',
                           status: :avaliable, employer: employer)
    app = Project.create!(title: 'Jogo mobile', description: 'Jogo para celulares android',
                          max_per_hour: 40.0, deadline: 50.days.from_now, place: 'Remoto',
                          status: :avaliable, employer: employer)
    date = 4.days.from_now.to_date
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: date,
                     project: site, worker: worker)
    Proposal.create!(description: 'Experiencia em app mobiles', hourly_value: 9.0,
                     hours_per_week: 15, date_close: 30.days.from_now,
                     project: app, worker: worker)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'

    expect(page).to have_content('Sou bom em fazer sites')
    expect(page).to have_content('Valor por hora: R$ 7,00')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content("Previsão de conclusão: #{date}")
    expect(page).to have_content('Status: pending')
    expect(page).to have_content('Perfil do freelancer: worker@email.com')
    expect(page).to have_content('Aceitar proposta')
    expect(page).to have_content('Rejeitar proposta')
    expect(page).not_to have_content('Experiencia em app mobiles')
    expect(page).not_to have_content('R$ 9,00')
    expect(page).not_to have_content('por semana: 15')
    expect(page).not_to have_content(30.days.from_now.to_date.to_s)
  end
end
