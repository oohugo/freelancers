require 'rails_helper'

describe 'Employer edit a project' do
  it 'stopping receiving proposals' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote', employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker)

    Proposal.create!(description: 'Especialista em webdesenvolvimento', hourly_value: 6.0,
                     hours_per_week: 25, date_close: 3.days.from_now,
                     project: project, worker: worker, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Suspender propostas'

    expect(page).to have_content('Especialista em webdesenvolvimento')
    expect(page).not_to have_content('Sou bom em fazer sites')
    expect(page).not_to have_content('Valor por hora: R$ 7,00')
    expect(page).not_to have_content('Horas disponíveis por semana: 20')
    expect(page).not_to have_content("Previsão de conclusão: #{4.days.from_now.to_date}")
  end

  it 'returning to receive proposals' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                    employer: employer, status: :suspend)
    PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                         birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                         expertise: 'Web', worker: worker)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Deixar disponível para propostas'
    logout(:user)
    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Descrição da proposta', with: 'texto justificando a proposta'
    fill_in 'Valor da hora', with: 7.0
    fill_in 'Horas disponível por semana', with: 20
    fill_in 'Expectativa de conclusão', with: 4.days.from_now
    click_on 'Enviar'

    expect(page).to have_content('Proposta enviada')
    expect(page).to have_content('Cancelar a proposta')
    expect(page).to have_content('Site para contratar freelancers')
  end

  it '... finished a project' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote', employer: employer)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Finalizar projeto'

    expect(page).to have_content('Projeto finalizado')
    expect(page).to have_content('Feedback')
    expect(page).to have_content(worker.email)
  end
end
