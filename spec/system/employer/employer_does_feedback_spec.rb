require 'rails_helper'

describe 'Employer does feedback of employer' do
  it 'successfully' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    project = Project.create!(title: 'Site de freelancer', description: 'Site para contratar freelancers',
                              max_per_hour: 10.0, deadline: 5.days.from_now, place: 'remote',
                              employer: employer, status: :finished)
    Proposal.create!(description: 'Sou bom em fazer sites', hourly_value: 7.0,
                     hours_per_week: 20, date_close: 4.days.from_now,
                     project: project, worker: worker, status: :accepted)

    login_as employer, scope: :employer
    visit root_path
    click_on 'Site de freelancer'
    click_on 'Dar feedback aos freelancers'
    fill_in 'Nota de 1 a 5', with: 4
    fill_in 'Comentário', with: 'Muito bom profissional'
    click_on 'Enviar'

    expect(page).to have_content('Feedback enviado')
  end

  it 'and employer see rating of freelancer' do
    worker = Worker.create!(email: 'email@email.com', password: '123456')
    perfil_worker = PerfilWorker.create!(full_name: 'João Severino', name: 'Severino', birthdate: '18/07/1992',
                                         qualification: 'Graduado em Ciências da Computação',
                                         background: 'Estágio blabla bla',expertise: 'Desenvolvimento', worker: worker)
    employer = Employer.create!(email: 'employer@email.com', password: '123456')
    FeedbackWorker.create!(comment: 'Fez tudo certo', rating: 5, worker: worker)
    FeedbackWorker.create!(comment: 'Fez tudo errado', rating: 2, worker: worker)
    worker.calculate_rating
    worker.save!
    login_as employer, scope: :employer
    visit perfil_worker_path(perfil_worker)

    expect(page).to have_content("Avaliação do freelancer: #{(5 + 2) / 2}")
  end
end
