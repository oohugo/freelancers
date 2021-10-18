require 'rails_helper'

describe 'Worker register proposal' do
  it 'succefully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                         birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                         expertise: 'Web', worker: worker)
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                    employer: Employer.create!(email: 'employer@email.com', password: '123456'))

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    fill_in 'Descrição da proposta', with: 'texto justificando a proposta'
    fill_in 'Valor da hora', with: 7.0
    fill_in 'Horas disponíveis por semana', with: 20
    fill_in 'Expectativa de conclusão', with: 4.days.from_now
    click_on 'Enviar'

    expect(page).to have_content('Proposta enviada')
    expect(page).to have_content('Cancelar a proposta')
    expect(page).not_to have_content('Justifique o cancelamento')
    expect(page).to have_content('Site para contratar freelancers')
  end
  context 'validations' do
    it ' cannot in a suspend project' do
      worker = Worker.create!(email: 'email@email.com', password: '123456')
      employer = Employer.create!(email: 'employer@email.com', password: '123456')
      project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                                max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                                employer: employer, status: :suspend)
      PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                           birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                           expertise: 'Web', worker: worker)
      login_as worker, scope: :worker
      visit project_path(project)
      expect(page).to have_content('Site de freelancer')
      expect(page).not_to have_content('Digite uma proposta')
    end
    it 'cannot in a finished a project' do
      worker = Worker.create!(email: 'email@email.com', password: '123456')
      employer = Employer.create!(email: 'employer@email.com', password: '123456')
      project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                                max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                                employer: employer, status: :finished)
      PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                           birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                           expertise: 'Web', worker: worker)
      login_as worker, scope: :worker
      visit project_path(project)
      expect(page).to have_content('Site de freelancer')
      expect(page).not_to have_content('Digite uma proposta')
    end
    it 'cannot create a proposal blank' do
      worker = Worker.create!(email: 'email@email.com', password: '123456')
      PerfilWorker.create!(full_name: 'Nome Completo', name: 'Nome',
                           birthdate: '12/12/2002', qualification: 'Graduado', background: 'bla bla',
                           expertise: 'Web', worker: worker)
      Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                      max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                      employer: Employer.create!(email: 'employer@email.com', password: '123456'))

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
