require 'rails_helper'

describe 'Freelancer does feedback of employer' do
  it 'successfully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'João Severino', name: 'Severino', birthdate: '18/07/1992',
                         qualification: 'Graduado em Ciências da Computação', background: 'Estágio blabla bla',
                         expertise: 'Desenvolvimento', worker: worker)
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                              employer: employer, status: :finished)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker, status: :accepted)

    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Dar feedback ao Empregador'
    fill_in 'Nota de 1 a 5', with: 4
    fill_in 'Comentário', with: 'Muito bom profissional'
    fill_in 'Comentário do projeto', with: 'Adorei trabalhar neste projeto'
    click_on 'Enviar'

    expect(page).to have_content('Feedback enviado')
    expect(page).to have_content('Site de freelancer')
    expect(page).to have_content('Avaliação do Empregador: 4')
  end

  it 'and freelancer see rating of employer' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    PerfilWorker.create!(full_name: 'João Severino', name: 'Severino', birthdate: '18/07/1992',
                         qualification: 'Graduado em Ciências da Computação',
                         background: 'Estágio blabla bla', expertise: 'Desenvolvimento', worker: worker)
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    FeedbackEmployer.create!(comment: 'Fez tudo certo', rating: 5, employer: employer)
    FeedbackEmployer.create!(comment: 'Fez tudo errado', rating: 2, employer: employer)
    Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                    max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                    employer: employer)
    project_finished = Project.create!(title: 'Site de locação', description: 'Site para alugar imóveis',
                                       max_per_hour: 10.0, deadline: 5.days.from_now, place: 'presential',
                                       status: :finished, employer: employer)

    FeedbackProject.create!(comment: 'Projeto muito bem feito pelo Empregador', project: project_finished)
    employer.calculate_rating
    employer.save!
    login_as worker, scope: :worker
    visit root_path
    click_on 'Site de freelancer'
    click_on employer.email

    expect(page).to have_content('Site de locação')
    expect(page).to have_content('Projeto muito bem feito pelo Empregador')
    expect(page).to have_content("Avaliação do Empregador: #{(5 + 2) / 2}")
  end
end
