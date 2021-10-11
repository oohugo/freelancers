require 'rails_helper'

describe 'Employer see proposal' do
  it 'succefully' do
    employer = Employer.create!(email: 'joao@email.com', password: '123456')
    worker = Worker.create!(email: 'worker@email.com', password: '123456')
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'Remoto',
                              status: :avaliable, employer: employer)
    date = 4.days.from_now.to_date
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: date,
                     project: project, worker: worker)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'

    expect(page).to have_content('Sou bom em fazer sites')
    expect(page).to have_content('Valor por hora: R$ 7,00')
    expect(page).to have_content('Horas disponíveis por semana: 20')
    expect(page).to have_content("Previsão de conclusão: #{date}")
    expect(page).to have_content('Status: pending')
    expect(page).to have_content('Perfil do freelancer')
    expect(page).to have_content('Aceitar proposta')
    expect(page).to have_content('Rejeitar proposta')
  end
end
