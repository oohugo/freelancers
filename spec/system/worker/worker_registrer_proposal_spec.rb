require 'rails_helper'

describe 'Worker register proposal' do
  it 'succefully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                         birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                         expertise: 'Web', worker: worker)
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'Remoto',
                    employer: Employer.create!(email: 'employer@email.com', password: '123456'))

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Digite uma proposta', with: 'texto justificando a proposta'
    fill_in 'Valor da hora', with: 7.0
    fill_in 'Horas disponível por semana', with: 20
    fill_in 'Expectativa de conclusão', with: 4.days.from_now
    click_on 'Enviar'

    expect(page).to have_content('Proposta enviada')
    expect(page).to have_content('Cancelar proposta')
    expect(page).to have_content('Site para contratar freelancers')
  end
  pending 'in a suspend project' 
    # worker = Worker.create!(email: 'email@email.com', password: '123456')
    # employer = Employer.create!(email: 'employer@email.com', password: '123456')
    # Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
    #                 max_per_hour: 10.0, deadline: 5.days.from_now, place: 'Remoto',
    #                 employer: employer, status: :suspend)
    # login_as worker, scope: :werker
    # visit root_path
    # click_on 'Site de freelancer'

  pending 'in finished a project'
  pending 'canceled a proposal'
end
