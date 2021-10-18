require 'rails_helper'

describe 'Worker cancel a proposal' do
  it 'successfully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'João Severino', name: 'Severino', birthdate: '18/07/1992',
                         qualification: 'Graduado em Ciências da Computação', background: 'Estágio blabla bla',
                         expertise: 'Desenvolvimento', worker: worker)
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                              employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Cancelar a proposta'

    expect(page).to have_content('Proposta cancelada')
    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Descrição da proposta')
    expect(page).not_to have_content('Cancelar a proposta')
  end

  it 'justification in cancel a proposal after 3 days confirmed' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'João Severino', name: 'Severino', birthdate: '18/07/1992',
                         qualification: 'Graduado em Ciências da Computação', background: 'Estágio blabla bla',
                         expertise: 'Desenvolvimento', worker: worker)
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                              employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker, status: :accepted,
                     date_accepted: 1.days.ago)
    travel 4.days
    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Justifique o cancelamento', with: 'Imprevisto aconteceu'
    click_on 'Cancelar a proposta'

    expect(page).to have_content('Proposta cancelada')
    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Descrição da proposta')
    expect(page).not_to have_content('Cancelar a proposta')
  end
end
